require 'rails_helper'

RSpec.describe ProductsController, type: :controller do
  let(:category) { FactoryGirl.create(:category) }
  describe 'GET #index' do
    it 'returns http success' do
      get :index, params: { category_id: category.id }.as_json, format: :json
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET #create' do
    context "when there are valid params" do
      before :each do
        post :create, params: { category_id: category.id,
          product: { name: "Fakename", price: 1 }.as_json }.as_json,
          format: :json
      end

      it 'returns http success' do
        expect(response).to have_http_status(201)
      end

      it 'responds with correct data' do
        parsed_response = JSON.parse(response.body)
        expect(parsed_response["name"]).to eq "Fakename"
        expect(parsed_response["price"].to_i).to be 1
      end
    end

    context "when there are invalid params" do
      before :each do
        post :create, params: { category_id: category.id,
          product: { name: "", price: 1 }.as_json }.as_json,
          format: :json
      end

      it 'returns http status 422' do
        expect(response).to have_http_status(422)
      end

      it 'responds with error message' do
        parsed_response = JSON.parse(response.body)
        expect(parsed_response["name"].first).to eq "can't be blank"
      end
    end
  end

  describe 'GET #delete' do
    let(:product) { FactoryGirl.create(:product, category_id: category.id) }
    it 'returns http status 204' do
      delete :delete, params: { id: product.id }.as_json, format: :json
      expect(response).to have_http_status(204)
    end
  end
end
