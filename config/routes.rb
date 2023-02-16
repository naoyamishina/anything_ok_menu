Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
  root 'static_pages#top'
  get 'privacy', to: 'static_pages#privacy'
  get 'terms', to: 'static_pages#terms'
  
  get 'login' => 'user_sessions#new', :as => :login
  post 'login' => "user_sessions#create"
  delete 'logout' => 'user_sessions#destroy', :as => :logout

  resources :users do
    get :likes
    get :eats
  end
  resources :menus do
    resources :comments, only: %i[create destroy], shallow: true
    collection do
      get :search_tag
    end
  end
  resources :likes, only: %i[create destroy]
  resources :eats, only: %i[index create destroy]
  resource :profile, only: %i[edit update]
  resources :password_resets, only: %i[new create edit update]

  namespace :admin do
    root to: 'dashboards#index'
    get 'login', to: 'user_sessions#new'
    post 'login', to: 'user_sessions#create'
    delete 'logout', to: 'user_sessions#destroy'
    resources :menus, only: %i[index edit update show destroy]
    resources :users, only: %i[index edit update show destroy]
  end
end
