require 'esign/api'

module Esign
  class TemplatesApi < Api

    # 查询模板文件详情
    # @see https://open.esign.cn/doc/detail?id=opendoc%2Fsaasapi-std%2Fviygk4&namespace=opendoc%2Fsaasapi-std
    def get_doc_template(template_id: nil)
      @client.get("/v1/docTemplates/#{template_id}")
    end

    # 查询e签宝官网模板信息
    # @see https://open.esign.cn/doc/detail?id=opendoc%2Fsaas_api%2Fuseb10&namespace=opendoc%2Fsaas_api
    def get_doc_templates(page: 1, per: 20)
      @client.get("/v3/flow-templates/basic-info?pageNum=#{page}&pageSize=#{per}")
    end
  end
end
