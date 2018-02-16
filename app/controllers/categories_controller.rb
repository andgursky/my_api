class CategoriesController < ApplicationController
  def index
    # GET /categories
    render status: 200,
           json: Category.all.as_json(only: %i[id name products_count])
  end

  def create
    # POST /categories
    new_category = Category.create(name: params['category']['name'])
    if new_category.errors.messages.any?
      render status: 422,
             json: new_category.errors.messages
    else
      render status: 201,
             json: new_category.as_json(only: %i[id name products_count])
    end
  end
end
