Rails.application.routes.draw do
  devise_for :users

  root to: "prototypes#index"

  resources :prototypes do
    resources :comments, onlu: :create
  end
  resources :users, only: :show
end
