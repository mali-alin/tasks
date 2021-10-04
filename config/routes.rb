Rails.application.routes.draw do
  devise_for :users

  root 'tasks#index'

  resources :tasks do
    member do
      get :start
      get :complete
      get :cancel
    end
    resources :approvals, only: [:create, :destroy]
  end
  resources :users, only: [:show, :edit, :update, :destroy]
end
