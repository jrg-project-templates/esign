require 'esign/api'

module Esign
  class FilesApi < Api
    # 查询PDF文件详情(查看所上传文件的当前状态、文件名称、文件大小和下载链接)
    # @see https://open.esign.cn/doc/opendoc/saas_api/fcqvxc
    def get_file_details(file_id: nil)
      @client.get("/v1/files/#{file_id}")&.parsed_response
    end
  end
end
