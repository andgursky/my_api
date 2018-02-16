class ProductsController < ApplicationController
  def index
    # GET /categories/:id/products
    render json: Category.find(params['category_id'])
      .products.as_json(only: %i[id name price])
  end

  def create
    # POST /categories/:id/products
    category = Category.find(params['category_id'])
    new_product = category.products.create(name: params['product']['name'],
                                           price: params['product']['price'])
    if new_product.errors.messages.any?
      render status: 422,
             json: new_product.errors.messages
    else
      render status: 201,
             json: new_product.as_json(only: %i[id name price])
    end
  end

  def delete
    # DELETE /products/:id
    product = Product.find(params['id']).destroy
    render status: 204 unless product.errors.messages.any?
  end
end
