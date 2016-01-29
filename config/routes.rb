Rails.application.routes.draw do
  resources :transactions, only: :index

  namespace :transactions do
    resource :deposit,  controller: 'deposit',   only: [:create, :new]
    resource :withdraw, controller: 'withdraw',  only: [:create, :new]
    resource :transfer, controller: 'transfer',  only: [:create, :new]
  end

  resources :accounts do
    resource :close, controller: 'accounts/close',  only: :update
  end

  devise_for :users, controllers:
    { registrations: "users/registrations",
      sessions:      "users/sessions" }

  root :to => 'home#index'
end
