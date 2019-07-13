Rails.application.routes.draw do
  root 'dashboard#index'

  resources :expenses

  namespace :charts do
    get 'semester_type'
    get 'type'
    get 'category'
    get 'accumulated'
  end

  namespace :api, defaults: {format: 'json'} do
    namespace :v1 do
      resources :expenses, only: [:show, :index, :create, :update, :destroy]
    end
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # Serve websocket cable requests in-process
  # mount ActionCable.server => '/cable'
end
