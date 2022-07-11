require 'esign/api'

module Esign
  class TemplatesApi < Api

    # 获取模板文件上传地址
    # @see https://open.esign.cn/doc/detail?id=opendoc%2Fsaas_api%2Fawgyis&namespace=opendoc%2Fsaas_api
    def get_doc_template_upload_url(params)
      @client.post("/v1/docTemplates/createByUploadUrl", params)&.parsed_response
    end

    # 查询模板文件上传状态(doc_template)
    # @see https://open.esign.cn/doc/detail?id=opendoc%2Fsaas_api%2Fmmrbd6&namespace=opendoc%2Fsaas_api
    def get_doc_template_base_info(doc_template_id: nil)
      @client.get("/v1/docTemplates/#{doc_template_id}/getBaseInfo")&.parsed_response
    end

    # 查询模板文件详情(doc_template)
    # @see https://open.esign.cn/doc/detail?id=opendoc%2Fsaasapi-std%2Fviygk4&namespace=opendoc%2Fsaasapi-std
    def get_doc_template(doc_template_id: nil)
      @client.get("/v1/docTemplates/#{doc_template_id}")&.parsed_response
    end

    # 查询e签宝官网模板信息(flow_template)
    # @see https://open.esign.cn/doc/detail?id=opendoc%2Fsaas_api%2Fuseb10&namespace=opendoc%2Fsaas_api
    def get_flow_templates(page: 1, per: 20)
      @client.get("/v3/flow-templates/basic-info?pageNum=#{page}&pageSize=#{per}")&.parsed_response
    end

    # 填充内容生成PDF
    # @see https://open.esign.cn/doc/detail?id=opendoc%2Fsaas_api%2Fsiipw3&namespace=opendoc%2Fsaas_api
    def create_file_by_doc_template(params)
      @client.post('/v1/files/createByTemplate', params)&.parsed_response
    end
  end
end
