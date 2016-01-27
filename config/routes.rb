Rails.application.routes.draw do
  resources :accounts do
    resource :close, controller: 'accounts/close',  only: :update
  end

  devise_for :users, controllers:
    { registrations: "users/registrations",
      sessions:      "users/sessions" }

  root :to => 'home#index'
end
