Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      get '/items/find', to: 'search#show'
      resources :items, only: [:index, :show, :create, :update, :destroy] do
        resources :merchant, only: [:index], module: :items
      end
      resources :merchants, only: [:index, :show, :create, :update, :destroy] do
        resources :items, only: [:index], module: :merchants
      end
    end
  end
end
