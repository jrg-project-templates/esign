module Esign
  class Api
    PRODUCTION_API_BASE = 'https://openapi.esign.cn'
    SANDBOX_API_BASE = 'https://smlopenapi.esign.cn/'

    DEFAULT_ENV_PLATFORM_MAPPING = {
      development: :sandbox,
      staging: :sandbox,
      production: :production
    }

    def initialize(platform: nil, appid: nil, secrect: nil)
      platform ||= DEFAULT_ENV_PLATFORM_MAPPING[ConfigLoader.env.to_sym]
      if [:sandbox, :production].include? platform
        puts '------- warning: unsupported enviroment, fallback to sandbox -------'
        platform = :sandbox
      end
      @api_base = platform == :production ? PRODUCTION_API_BASE : SANDBOX_API_BASE
      @client = HttpClient.new(base_uri: @api_base, appid: appid, secrect: secrect )
    end

  end
end
