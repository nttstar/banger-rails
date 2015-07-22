require 'net/http'
require 'json'
class ProductsController < ApplicationController
  include ProductsHelper
  def comparison
    @q = params[:q]
    if @q.nil?
      @docid = params[:docid]
      @err = nil
      @products = []
      if @docid.nil?
        @err = "Please set DOCID or product url"
      elsif @docid.size!=32
        @err = "DOCID not set properly"
      else
        uri = URI("http://#{Rails.configuration.comparison_ip}:#{Rails.configuration.comparison_port}/?docid=#{@docid}")
        response = nil
        begin
          response = Net::HTTP.get(uri)
          @products = JSON.parse(response)
        rescue
          @err = "get response error"
        end
      end
    else
      docid = get_docid_by_query(@q)
      docid = "" if docid.nil?
      redirect_to :docid => docid
    end
  end
end
