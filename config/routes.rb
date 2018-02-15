Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  #post '/create', action: 'create', controller: 'categories'

  delete '/products/:id' => 'products#delete'

  resources :categories, only: %i[create index] do
    #get ':id/products', action: :index,  controller: 'products'
    #post ':id/products', action: :create,  controller: 'products'
    resources :products, only: %i[index create]
  end
end
