Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      get 'items/find', to: 'search#show'
      resources :items do
        # get ':search(/:action(/:id))'
        get '/items', to: 'items#index'
        get '/items/:id', to: 'items#show'
        post '/items', to: 'items#create'
        patch '/items/:id', to: 'items#update'
        delete '/items/:id', to: 'items#destroy'
        resources :merchant, only: [:index], module: :items
      end
      resources :merchants, only: [:index, :show, :create, :update, :destroy] do
        resources :items, only: [:index], module: :merchants
      end
    end
  end
end
