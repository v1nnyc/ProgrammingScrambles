Rails.application.routes.draw do

    # Obligatory Home Root
    root :to => 'home#index'

    # Devise Related Routes.
    # Inherited classes that need skips.
    devise_for :teachers, skip: :sessions
    devise_for :students, skip: :sessions

    # Map generic routes to variables for ApplicationController
    # Devise overrides.
    devise_for :users, skip: :registrations do
        delete 'logout', to: '/users/sessions#destroy', as: :destroy_user_session
        get 'login', to: '/users/sessions#new', as: :new_user_session
        put 'login', to: '/users/session#create', as: :user_session
    end

    #Homepage Related Routes
    get 'home' => 'home#index'

    #Dashboard Related Routes
    get 'dashboard/index' => 'dashboard#index', as: :user_dashboard




end
