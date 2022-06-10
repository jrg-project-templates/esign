require 'esign/api'
require 'esign/http_client'

module Esign
  autoload :VERSION, "esign/version"

  def self.api
    @api ||= ConfigLoader.fetch
  end

  def self.reload_config!
    ConfigLoader.reload_config!
  end
end
