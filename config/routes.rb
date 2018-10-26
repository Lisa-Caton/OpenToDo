Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    resources :users do
      resources :lists
    end

    resources :lists, only: [] do
      resources :items, only: [:index, :create]
    end

    resources :items, only: [:destroy]
  end
end


#http://localhost:3000/api/users/

#http://localhost:3000/api/users/1/lists

#http://localhost:3000/api/lists/1/items
