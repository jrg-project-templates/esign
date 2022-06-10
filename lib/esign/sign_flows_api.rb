require 'esign/api'
require 'esign/http_client'

module Esign
  class SignFlowsApi << Api

    # @api 一步发起签署
    # @see https://open.esign.cn/doc/detail?id=opendoc%2Fsaas_api%2Fwwww1b_worixg&namespace=opendoc%2Fsaas_api
    def create_flow_one_step(params)
      @client.post('/api/v2/signflows/createFlowOneStep', params)
    end

    # @api 签署流程创建
    # @see https://open.esign.cn/doc/detail?id=opendoc%2Fsaas_api%2Fit95b1_bki3w5&namespace=opendoc%2Fsaas_api
    def create_sign_flows(params)
      @client.post('/api/v1/signflows', params)
    end
  end
end
