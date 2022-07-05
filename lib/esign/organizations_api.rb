require 'esign/api'

module Esign
  class OrganizationsApi < Api

    # 创建机构签署账号
    # @see https://open.esign.cn/doc/opendoc/saas_api/kidg8y_gc0q92
    def create_by_custom_user_id(params)
      @client.post("/v1/organizations/createByThirdPartyUserId", params)&.parsed_response
    end

    # 查询机构签署账号
    # @see by orgId: https://open.esign.cn/doc/opendoc/saas_api/om3d9g_ceofi9
    # @see by thirdPartyUserId: https://open.esign.cn/doc/opendoc/saas_api/yx41la_gdpkg8
    def get_organization(org_id: nil, custom_user_id: nil)
      if org_id.present?
        @client.get("/v1/organizations/#{org_id}")&.parsed_response
      elsif custom_user_id.present?
        @client.get("/v1/organizations/getByThirdId?thirdPartyUserId=#{custom_user_id}")&.parsed_response
      end
    end

    # 修改机构签署账号
    # @see by orgId: https://open.esign.cn/doc/opendoc/saas_api/xvz83y_np9hgc
    # @see by thirdPartyUserId: https://open.esign.cn/doc/opendoc/saas_api/dm0ani_srn6f5
    def edit_organization(params)
      org_id = params[:org_id]
      custom_user_id = params[:custom_user_id]
      request_params = params.reject {|k| ['org_id', 'custom_user_id'].include?(k.to_s)}
      if org_id.present?
        @client.put("/v1/organizations/#{org_id}", request_params)&.parsed_response
      elsif custom_user_id.present?
        @client.put("/v1/organizations/updateByThirdId?thirdPartyUserId=#{custom_user_id}", request_params)&.parsed_response
      end
    end

    # 注销机构签署账号
    # @see by orgId: https://open.esign.cn/doc/opendoc/saas_api/zyhs1z_zfykes
    # @see by thirdPartyUserId: https://open.esign.cn/doc/opendoc/saas_api/krvfdm_iy1ft4
    def delete_organization(org_id: nil, custom_user_id: nil)
      if org_id.present?
        @client.delete("/v1/organizations/#{org_id}")&.parsed_response
      elsif custom_user_id.present?
        @client.delete("/v1/organizations/deleteByThirdId?thirdPartyUserId=#{custom_user_id}")&.parsed_response
      end
    end

  end
end
