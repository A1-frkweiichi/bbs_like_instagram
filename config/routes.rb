Rails.application.routes.draw do
  root "posts#index"
  resources :posts

  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  get "up" => "rails/health#show", as: :rails_health_check
end
