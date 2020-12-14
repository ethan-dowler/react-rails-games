# For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
Rails.application.routes.draw do
  devise_for :users

  root "home#index"

  namespace :admin do
    root "home#index"
  end

  ## Authentication
  # Browser
  constraints format: :html do
    resources :login, only: %i(index create)
  end
  # API
  constraints format: :json do
    namespace :api do
      resources :authentication, only: :create
    end
  end
end
