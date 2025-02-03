Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  # root "posts#index"

  resources :courses do 
    resources :lessons do 
      resources :quizzes
    end

    member do 
      post 'enroll', to: "enrollments#create"
      delete 'unenroll', to: "enrollments#destroy"
    end
  end

  resources :enrollments, only: [:index, :show, :destroy]

  #admin 

  namespace :admin do 
    resources :users, only: [:index, :show, :edit, :update, :destroy]
    resources :courses, only: [:index, :show, :edit, :update, :destroy]
  end 

  namespace :instructor do 
    resources :courses, only: [:index, :show, :new, :create, :edit, :update, :destroy] do
      resources :lessons, only: [:new, :create, :edit, :update, :destroy] do
        resources :quizzes, only: [:new, :create, :edit, :update, :destroy]
      end
    end
  end

  namespace :students do 
    resources :courses, only: [:index, :show] do
      resources :lessons, only: [:show] do
        resources :quizzes, only: [:show, :create]
      end
    end
  end

  get 'search', to: 'courses#search'
end
