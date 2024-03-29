module Esign
  class Api
    PRODUCTION_API_BASE = 'https://openapi.esign.cn'
    SANDBOX_API_BASE = 'https://smlopenapi.esign.cn'
    # SANDBOX_API_BASE = 'http://localhost:3000'

    DEFAULT_ENV_PLATFORM_MAPPING = {
      development: :sandbox,
      staging: :sandbox,
      production: :production
    }

    def initialize(platform: nil, appid: nil, secrect: nil)
      platform ||= DEFAULT_ENV_PLATFORM_MAPPING[ConfigLoader.env.to_sym]
      platform = platform&.to_sym
      unless [:sandbox, :production].include? platform
        puts '------- WARNING: unsupported enviroment, fallback to sandbox -------'
        platform = :sandbox
      end
      @api_base = platform == :production ? PRODUCTION_API_BASE : SANDBOX_API_BASE
      @client = HttpClient.new(base_url: @api_base, appid: appid, secrect: secrect )
    end
  end
end
