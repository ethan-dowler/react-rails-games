Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root "home#index"
  constraints format: :json do
    namespace :api do
      resources :authentication, only: :create
    end
  end
end
