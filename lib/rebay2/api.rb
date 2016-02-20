require 'net/http'
require 'json'
require 'uri'

module Rebay2
  class Api
    # default site is EBAY_US, for other available sites see eBay documentation:
    # http://developer.ebay.com/DevZone/merchandising/docs/Concepts/SiteIDToGlobalID.html
    EBAY_US = 0

    class << self
      attr_accessor :customer_id, :network_id, :tracking_id, :app_id, :default_site_id, :sandbox
    
      def base_url
        [base_url_prefix,
         sandbox ? "sandbox" : nil,
         base_url_suffix].compact.join('.')
      end

      def base_url_prefix
        "http://svcs"
      end

      def base_url_suffix
        "ebay.com"
      end

      def sandbox
        @sandbox ||= false
      end
      
      def default_site_id
        @default_site_id || EBAY_US
      end

      def network_id
        @network_id ||= 9
      end
      
      def configure
        yield self if block_given?
      end
    end

    protected
    
    def get_json_response(url)
      Rebay::Response.new(JSON.parse(Net::HTTP.get_response(URI.parse(url)).body))
    end

    def build_rest_payload(params)
      payload = ''
      unless params.empty?
        params.keys.each do |key|
          payload += URI.escape "&#{key}=#{params[key]}"    
        end
      end

      unless Rebay2::Api.tracking_id.nil?
        Rebay2::Api.network_id ||= 9
        payload += URI.escape "&affiliate.trackingId=#{Rebay2::Api.tracking_id}&affiliate.networkId=#{Rebay2::Api.network_id}"
        payload += URI.escape "&affiliate.customId=#{Rebay2::Api.customer_id}" unless Rebay2::Api.customer_id.nil?
      end

      return payload
    end
  end
end
