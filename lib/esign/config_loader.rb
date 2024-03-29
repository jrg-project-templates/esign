module Esign
  module ConfigLoader
    @config = nil

    class << self
      def fetch
        @config ||= load_config!
      end

      def load_config!
        config = config_from_file
        if config.nil?
          puts '------- ERROR: cannot found valid config file -------'
          return;
        end
        config = config.transform_keys{ |key| key.to_sym }
      end

      def reload_config!
        @config = load_config!
      end

      def env
        if defined?(::Rails)
          Rails.env.to_s
        else
          ENV['RAILS_ENV'] || 'development'
        end
      end

      private

      def config_from_file
        if defined?(::Rails)
          config_file = Rails.root.join('config', 'esign.yml')
          resolve_config_file(config_file, env)
        else
          rails_config_file = File.join(Dir.getwd, 'config', 'esign.yml')
          if File.exist?(rails_config_file)
            resolve_config_file(rails_config_file, env)
          end
        end
      end

      def resolve_config_file(config_file, env)
        return unless File.exist?(config_file)
        begin
          raw_data = YAML.load(ERB.new(File.read(config_file)).result)
        rescue NameError
        end
        config = nil
        if env
          raw_data.each do |key, value|
            if key == env
              config = value
            else
              m = /(.*?)_#{env}$/.match(key)
              config = value if m
            end
          end
        else
          config = raw_data
        end
        config
      end
    end

  end
end
