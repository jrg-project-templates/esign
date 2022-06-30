require 'esign/api'
require 'esign/http_client'

module Esign
  class SignFlowsApi < Api

    # 一步发起签署
    # @see https://open.esign.cn/doc/detail?id=opendoc%2Fsaas_api%2Fwwww1b_worixg&namespace=opendoc%2Fsaas_api
    def create_flow_one_step(params)
      @client.post('/api/v2/signflows/createFlowOneStep', params)&.parsed_response
    end

    # 签署流程创建
    # @see https://open.esign.cn/doc/detail?id=opendoc%2Fsaas_api%2Fit95b1_bki3w5&namespace=opendoc%2Fsaas_api
    def create_signflow(params)
      @client.post('/v1/signflows', params)&.parsed_response
    end

    # 签署流程查询
    # @see https://open.esign.cn/doc/detail?id=opendoc%2Fsaas_api%2Fhgdcd6_lyclgb&namespace=opendoc%2Fsaas_api
    def get_signflow(flow_id: nil)
      @client.post("/v1/signflows/#{flow_id}")&.parsed_response
    end

    # 签署流程开启
    # @see https://open.esign.cn/doc/detail?id=opendoc%2Fsaas_api%2Fgx64qt_vgw9qn&namespace=opendoc%2Fsaas_api
    def start_signflow(flow_id: nil)
      @client.put("/v1/signflows/#{flow_id}/start")
    end

    # 流程签署人催签
    # @see https://open.esign.cn/doc/opendoc/saas_api/ezkln0_rgwmgp
    def rush_sign(params)
      @client.put("/v1/signflows/#{params[:flow_id]}/signers/rushsign", params.reject {|p| p == :flow_id} || {})
    end
  end
end
