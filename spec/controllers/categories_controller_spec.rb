require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do
  describe "GET :index" do
    it "responds with status 200" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST :create" do
    let(:category) do
      { category: { name: "Fakename" } }
    end.as_json

    context "when there are valid params" do
      before :each do
        post :create, params: category, format: :json
      end

      it "responds with status 201 if new category was created" do
        expect(response).to have_http_status(:success)
      end

      it "responds with correct data" do
        parsed_response = JSON.parse(response.body)
        expect(parsed_response["name"]).to eq "Fakename"
        expect(parsed_response["products_count"]).to be 0
      end
    end

    context "when there are invalid params" do
      let!(:same_category) { FactoryGirl.create(:category, name: "Fakename") }

      before :each do
        post :create, params: category, format: :json
      end

      it "response with status 422" do
        expect(response).to have_http_status(422)
      end

      it "raturns a message with an error" do
        parsed_response = JSON.parse(response.body)
        expect(parsed_response["name"].first).to eq "has already been taken"
      end
    end
  end
end
