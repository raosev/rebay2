module Rebay2
  class Merchandising < Rebay2::Api
    def self.base_url_suffix
      "ebay.com/MerchandisingService"
    end
    VERSION = '1.5.0'
    #http://developer.ebay.com/devzone/merchandising/docs/CallRef/getMostWatchedItems.html
    def get_most_watched_items(params)
      #raise ArgumentError unless params[:categoryId]
      response = get_json_response(build_request_url('getMostWatchedItems', params))
      response.trim(:getMostWatchedItemsResponse)
      if response.response.has_key?('itemRecommendations') && response.response['itemRecommendations'].has_key?('item')
        response.results = response.response['itemRecommendations']['item']
      end
      return response
    end

    def get_related_category_items(params)
      raise ArgumentError unless params[:categoryId] or params[:itemId]
      response = get_json_response(build_request_url('getRelatedCategoryItems', params))
      response.trim(:getRelatedCategoryItemsResponse)
      if response.response.has_key?('itemRecommendations') && response.response['itemRecommendations'].has_key?('item')
        response.results = response.response['itemRecommendations']['item']
      end
      return response
    end

    def get_similar_items(params)
      raise ArgumentError unless params[:itemId]
      response = get_json_response(build_request_url('getSimilarItems', params))
      response.trim(:getSimilarItemsResponse)
      if response.response.has_key?('itemRecommendations') && response.response['itemRecommendations'].has_key?('item')
        response.results = response.response['itemRecommendations']['item']
      end
      return response
    end

    def get_top_selling_products(*params)
      response = get_json_response(build_request_url('getTopSellingProducts', params||= nil))
      response.trim(:getTopSellingProductsResponse)
      if response.response.has_key?('productRecommendations') && response.response['productRecommendations'].has_key?('product')
        response.results = response.response['productRecommendations']['product']
      end
      return response
    end

    def get_version(*params)
      response = get_json_response(build_request_url('getVersion', params))
      response.trim(:getVersionResponse)
      if response.response.has_key?('version')
        response.results = response.response['version']
      end
      return response
    end


    private    
    def build_request_url(service, params=nil)
      url = "#{self.class.base_url}?OPERATION-NAME=#{service}&SERVICE-NAME=MerchandisingService&SERVICE-VERSION=#{VERSION}&SECURITY-APPNAME=#{Rebay2::Api.app_id}&RESPONSE-DATA-FORMAT=JSON&REST-PAYLOAD"
      url += build_rest_payload(params)
      return url
    end
  end
end