Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  #post '/create', action: 'create', controller: 'categories'
  resources :categories, only: %i[create index]
end
