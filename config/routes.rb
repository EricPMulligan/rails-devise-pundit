Rails.application.routes.draw do
  root to: 'visitors#index'
  devise_for :users
  resources :users do
    resources :labels, only: [:new, :create, :edit, :update, :destroy]
  end
end
