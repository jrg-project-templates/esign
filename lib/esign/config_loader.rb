module Esign
  module ConfigLoader
    @config = nil

    class << self
      def fetch
        @config ||= load_config!
      end

      def load_config!
        config = config_from_file
        config.symbolize_keys!
        OpenStruct.new(config)
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

      private_class_method def config_from_file
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

      private_class_method def self.resolve_config_file(config_file, env)
        return unless File.exist?(config_file)
        begin
          raw_data = YAML.load(ERB.new(File.read(config_file)).result)
        rescue NameError
        end
        configs = {}
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
