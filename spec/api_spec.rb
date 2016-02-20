require 'spec_helper'


module Rebay2
  describe Api do
    describe "#configure" do
      it "should respond to configure" do
        Rebay2::Api.should respond_to(:configure)
      end
      
      describe "#base_url_prefix" do
        it "shouldn't be nil" do
          Rebay2::Api.base_url_prefix.should_not be_nil
        end
      end

      describe "#base_url_suffix" do
        it "shouldn't be nil" do
          Rebay2::Api.base_url_suffix.should_not be_nil
        end
      end
      
      describe "#base_url" do
        context "api calls should hit the sandbox" do
          it "should return a sandboxed url" do
            Rebay2::Api.configure do |c|
              c.sandbox = true
            end
          
            Rebay2::Api.base_url.should include "sandbox"
          end
        end

        context "api calls shouldn't hit the sandbox" do
          it "should return a un-sandboxed url" do
            Rebay2::Api.configure do |c|
              c.sandbox = false
            end

            Rebay2::Api.base_url.should_not include "sandbox"
          end
        end
      end

      describe "#sandbox" do
        it_behaves_like "a configuration option", :sandbox, true
      end
      
      describe "#app_id" do
        it_behaves_like "a configuration option", :app_id, 'super_id-11'
      end

      describe "#network_id" do
        it_behaves_like "a configuration option", :network_id, 9
      end

      describe "#tracking_id" do
        it_behaves_like "a configuration option", :tracking_id, '0123456789'
      end

      describe "#default_site_id" do
        it_behaves_like "a configuration option", :default_site_id, 100

        it "should default to EBAY_US" do
          Rebay2::Api.default_site_id.should eq Rebay2::Api::EBAY_US
        end
      end
    end

    context "when calling build_rest_payload" do
      before(:each) do
        @api = Rebay2::Api.new
      end

      it "should build rest payload from hash" do
        payload = @api.send(:build_rest_payload, {:test=>'blah', :test2=>'blah', :test3=>'blah'})
        payload.should include("&test=blah")
        payload.should include("&test2=blah")
        payload.should include("&test3=blah")
      end

      it "should escape html chars" do
         payload = @api.send(:build_rest_payload, {:test=>'blah', :test2=>'blah', :test3=>'blah blah'})
         payload.should include("&test=blah")
         payload.should include("&test2=blah")
         payload.should include("&test3=blah%20blah")
      end
    end

    context "calling build rest payload from hash w/ affiliate info" do
      before(:each) do
        @api = Rebay2::Api.new
        Rebay2::Api.tracking_id = '0123456789'
      end

      it "includes affiliate info" do
        payload = @api.send(:build_rest_payload, {})
        expect(payload).to eq("&affiliate.trackingId=0123456789&affiliate.networkId=9")
      end

      it "includes affiliate customer id" do
        Rebay2::Api.customer_id = 'ewaxx'
        payload = @api.send(:build_rest_payload, {})
        expect(payload).to eq("&affiliate.trackingId=0123456789&affiliate.networkId=9&affiliate.customId=ewaxx"
)
      end
    end
  end
end