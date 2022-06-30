require 'esign/api'
require 'esign/sign_flows_api'
require 'esign/files_api'
require 'esign/templates_api'
require 'esign/http_client'
require 'esign/config_loader'

module Esign
  autoload :VERSION, "esign/version"

  def self.config
    @config ||= ConfigLoader.fetch
  end

  def self.api(category = :default)
    @apis ||= {}
    category = category.to_sym
    category = valid_api_categories.include?(category) ? category : :default
    api_class_name = "#{category.to_s}_api".split('_').collect(&:capitalize).join
    @apis[category.to_sym] ||= Esign.const_get(api_class_name).new(config)
  end

  def self.valid_api_categories
    [:sign_flows, :files, :templates, :signers, :organizations, :default]
  end

  def self.reload_config!
    ConfigLoader.reload_config!
  end
end
