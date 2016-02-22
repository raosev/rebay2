require 'spec_helper'

module Rebay2
  describe Merchandising do
    before do
      @merchandising = Merchandising.new
      @merchandising.stub(:get_json_response).and_return(Rebay2::Response.new({"Ack" => 'Success'}))
    end

    it "specifies base url" do
      expect(Merchandising.base_url).not_to be_nil
    end

    it "specifies version" do
      expect(Merchandising::VERSION).not_to be_nil
    end

    context "after creation" do
      it "provide get_most_watched_items" do
        expect(@merchandising).to respond_to(:get_most_watched_items)
      end

      it "provides get_related_category_items" do
        expect(@merchandising).to respond_to(:get_related_category_items)
      end

      it "provides get_similar_items" do
        expect(@merchandising).to respond_to(:get_similar_items)
      end

      it "provides get_top_selling_products" do
        expect(@merchandising).to respond_to(:get_top_selling_products)
      end
    end

    context "calling get_most_watched_items" do
      it "Doesn't fails without args" do
        expect{@merchandising.get_most_watched_items }.not_to raise_error(ArgumentError)
      end
      
      it "returns a hash response with categoryId as parameter" do
        expect(@merchandising.get_most_watched_items({:categoryId => 1, :itemId => 1241343}).class).to eq(Rebay2::Response)
      end

      it "succeeds" do
        expect(@merchandising.get_most_watched_items({:categoryId => 1}).success?).to be true
      end

      it "iterates over results" do
        json = JSON.parse(File.read(File.dirname(__FILE__) + "/json_responses/merchandising/get_most_watched_items"))
        @merchandising.stub(:get_json_response).and_return(Rebay2::Response.new(json))
        response = @merchandising.get_most_watched_items({:categoryId => 1})
        
        count = 0
        response.each { |r| count = count + 1 }
        expect(count).to eq(2)
      end

      it "works with 1 result" do
        json = JSON.parse(File.read(File.dirname(__FILE__) + "/json_responses/merchandising/get_most_watched_items_one_item"))
        @merchandising.stub(:get_json_response).and_return(Rebay2::Response.new(json))
        response = @merchandising.get_most_watched_items({:categoryId => 1})
        
        count = 0
        response.each { |r| count = count + 1 }
        expect(count).to eq(1)
      end
    end

    context "calling get related category items" do
      it "fails without args" do
        expect{@merchandising.get_related_category_items }.to raise_error(ArgumentError)
      end
      
      it "returns a hash response with categoryId as parameter" do
        expect(@merchandising.get_related_category_items({:categoryId => 1}).class).to eq(Rebay2::Response)
      end

      it "returns a hash response with itemId as parameter" do
        expect(@merchandising.get_related_category_items({:itemId => 1}).class).to eq(Rebay2::Response)
      end

      it "succeeds" do
        expect(@merchandising.get_related_category_items({:categoryId => 1}).success?).to be true
      end

      it "iterates over results" do
        json = JSON.parse(File.read(File.dirname(__FILE__) + "/json_responses/merchandising/get_related_category_items"))
        @merchandising.stub(:get_json_response).and_return(Rebay2::Response.new(json))
        response = @merchandising.get_related_category_items({:categoryId => 1})
        
        count = 0
        response.each { |r| count = count + 1 }
        expect(count).to eq(2)
      end

      it "works with 1 result" do
        json = JSON.parse(File.read(File.dirname(__FILE__) + "/json_responses/merchandising/get_related_category_items_one_item"))
        @merchandising.stub(:get_json_response).and_return(Rebay2::Response.new(json))
        response = @merchandising.get_related_category_items({:categoryId => 1})
        
        count = 0
        response.each { |r| count = count + 1 }
        expect(count).to eq(1)
      end
    end

    context "calling get similar items" do
      it "fails without args" do
        expect{@merchandising.get_similar_items }.to raise_error(ArgumentError)
      end

      it "returns a hash response with itemId as parameter" do
        expect(@merchandising.get_similar_items({:itemId => 1}).class).to eq(Rebay2::Response)
      end

      it "succeeds" do
        expect(@merchandising.get_similar_items({:itemId => 1}).success?).to be true
      end

      it "iterates over results" do
        json = JSON.parse(File.read(File.dirname(__FILE__) + "/json_responses/merchandising/get_similar_items"))
        @merchandising.stub(:get_json_response).and_return(Rebay2::Response.new(json))
        response = @merchandising.get_similar_items({:itemId => 1})
        
        count = 0
        response.each { |r| count = count + 1 }
        expect(count).to eq(2)
      end

      it "works with 1 result" do
        json = JSON.parse(File.read(File.dirname(__FILE__) + "/json_responses/merchandising/get_similar_items_one_item"))
        @merchandising.stub(:get_json_response).and_return(Rebay2::Response.new(json))
        response = @merchandising.get_similar_items({:itemId => 1})
        
        count = 0
        response.each { |r| count = count + 1 }
        expect(count).to eq(1)
      end
    end

    context "calling get_top_selling_products" do
      it "does not fail without args" do
        expect{@merchandising.get_top_selling_products}.not_to raise_error(ArgumentError)
      end
      
      it "returns a hash response" do
        expect(@merchandising.get_top_selling_products.class).to eq(Rebay2::Response)
      end

      it "succeeds" do
        expect(@merchandising.get_top_selling_products.success?).to be true
      end

      it "iterates over results" do
        json = JSON.parse(File.read(File.dirname(__FILE__) + "/json_responses/merchandising/get_top_selling_products"))
        @merchandising.stub(:get_json_response).and_return(Rebay2::Response.new(json))
        response = @merchandising.get_top_selling_products
        
        count = 0
        response.each { |r| count = count + 1 }
        expect(count).to eq(20)
      end

      it "works with 1 result" do
        json = JSON.parse(File.read(File.dirname(__FILE__) + "/json_responses/merchandising/get_top_selling_products_one_item"))
        @merchandising.stub(:get_json_response).and_return(Rebay2::Response.new(json))
        response = @merchandising.get_top_selling_products
        
        count = 0
        response.each { |r| count = count + 1 }
        expect(count).to eq(1)
      end
    end
    context "when calling get_version" do
      it "should return a hash response" do
        expect(@merchandising.get_version.class).to eq(Rebay2::Response)
      end
      
      it "should succeed" do
        expect(@merchandising.get_version.success?).to be true
      end
      
      it "should iterate over results" do
        json = JSON.parse(File.read(File.dirname(__FILE__) + "/json_responses/merchandising/get_version"))
        @merchandising.stub(:get_json_response).and_return(Rebay2::Response.new(json))
        response = @merchandising.get_version
        
        count = 0
        response.each { |r| count = count + 1 }
        expect(count).to eq(1)
        
        expect(response.results).to eq('1.8.0')
      end
    end
  end
end
