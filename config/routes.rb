# frozen_string_literal: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  post 'sign_up' => 'users/registration#sign_up'
  post 'signin' => 'users/sessions#signin'
  # Defines the root path route ("/")
  # root "posts#index"

  resources :groups, param: :group_uuid do
    member do
      resources :expenses, param: :expense_uuid do
        collection do
          get :stats
        end
      end
      post 'generate_invite'
    end
    collection do
      post 'process_invite'
    end
  end

  namespace :users do
    resources :users, only: %i[show update]
  end
end
