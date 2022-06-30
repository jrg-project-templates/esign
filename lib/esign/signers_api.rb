require 'esign/api'

module Esign
  class SignersApi < Api

    # 创建个人签署账号
    # @see https://open.esign.cn/doc/opendoc/saas_api/pauo9z_xglzvk
    def create_by_custom_user_id(params)
      @client.post("/v1/accounts/createByThirdPartyUserId", params)&.parsed_response
    end

    # 查询个人签署账号
    # @see by accountId: https://open.esign.cn/doc/opendoc/saas_api/hg0bqf_nwkk96
    # @see by thirdPartyUserId: https://open.esign.cn/doc/opendoc/saas_api/ro7uun_eo4w1d
    def get_signer(account_id: nil, custom_user_id: nil)
      if account_id.present?
        @client.get("/v1/accounts/#{account_id}")&.parsed_response
      elsif custom_user_id.present?
        @client.get("/v1/accounts/getByThirdId?thirdPartyUserId=#{custom_user_id}")&.parsed_response
      end
    end

    # 修改个人签署账号
    # @see by accountId: https://open.esign.cn/doc/opendoc/saas_api/tzi4kd_ma1d8m
    # @see by thirdPartyUserId: https://open.esign.cn/doc/opendoc/saas_api/qngs1y_ia0u4u
    def edit_signer(params)
      account_id = params[:account_id]
      custom_user_id = params[:custom_user_id]
      request_params = params.reject {|k| ['account_id', 'custom_user_id'].include?(k.to_s)}
      if account_id.present?
        @client.put("/v1/accounts/#{account_id}", request_params)&.parsed_response
      elsif custom_user_id.present?
        @client.put("/v1/accounts/updateByThirdId?thirdPartyUserId=#{custom_user_id}", request_params)&.parsed_response
      end
    end

    # 注销个人签署账号
    # @see by accountId: https://open.esign.cn/doc/opendoc/saas_api/zsyrrr_xx8g4u
    # @see by thirdPartyUserId: https://open.esign.cn/doc/opendoc/saas_api/mk8sck_rthcvv
    def delete_signer(account_id: nil, custom_user_id: nil)
      if account_id.present?
        @client.delete("/v1/accounts/#{account_id}")&.parsed_response
      elsif custom_user_id.present?
        @client.delete("/v1/accounts/deleteByThirdId?thirdPartyUserId=#{custom_user_id}")&.parsed_response
      end
    end

  end
end
