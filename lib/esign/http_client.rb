require 'digest'
require 'time'
require 'httparty'

module Esign
  class HttpClient
    include HTTParty

    def initialize(base_uri: nil, appid: nil, secrect: nil)
      @base_uri = base_uri
      @appid = appid
      @secrect = secrect
    end

    def get(url, params = {})
      request_wrapper(url: url, params: params, method: 'GET') do |options, headers|
        self.class.get(options[:url], {query: options[:params], headers: headers})
      end
    end

    def post(uri, params = {})
      request_wrapper(url: url, params: params, method: 'POST') do |options, headers|
        self.class.post(options[:url],{body: options[:params], headers: headers})
      end
    end

    protected

    def request_wrapper(options, tries = 2)
      options[:params] ||= {}
      headers = generate_header(options)
      response = yield(options, headers.transform_keys{ |key| key.to_s })

    # rescue
    #   retry unless (tries -= 1).zero?
    end

    def generate_header(options)
      content_md5 = generate_content_md5(options)
      options = get_options(options) { {content_md5: content_md5} }
      {
        'X-Tsign-Open-App-Id': @appid,
        'Content-Type': options[:content_type], 
        'Accept': options[:accept],
        'X-Tsign-Open-Ca-Timestamp': options[:timestamp],
        'X-Tsign-Open-Ca-Signature': generate_signature_string(options),
        'Content-MD5': content_md5,
        'X-Tsign-Open-Auth-Mode': 'Signature'
      }
    end

    def get_options(options)
      now = Time.now
      default_options = {
        method: 'GET',
        accept: '*/*',
        content_type: 'application/json;charset=UTF-8',
        time_string: now.rfc822.to_s,
        time: now,
        timestamp: (Time.now.to_f * 1000).round,
        headers_string: '',
        params: {}
      }
      results = default_options.merge(options)
      if block_given?
        results = results.merge(yield)
      end
      results
    end

    private

    def generate_signature_string(options)
      plain_string = generate_plain_string(options)
      sha256_string = OpenSSL::HMAC.digest(OpenSSL::Digest.new('sha256'), @secrect, plain_string)
      Base64.encode64 sha256_string
    end

    def generate_plain_string(options)
      options = get_options(options)
      options[:method].upcase + '\n' 
        + options[:accept] + '\n'
        + options[:content_md5] + '\n'
        + options[:content_type] + '\n'
        + options[:time_string] + '\n' + 
        + options[:headers_string]
        + options[:url]
    end

    def generate_content_md5(options)
      options = get_options(options)
      return '' if options[:params].empty?
      content = options[:params].to_s
      Base64.encode64 Digest::MD5.hexdigest(content)
    end
  end
end
