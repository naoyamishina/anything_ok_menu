Rails.application.routes.draw do
  root 'static_pages#top'
  
  get 'login' => 'user_sessions#new', :as => :login
  post 'login' => "user_sessions#create"
  delete 'logout' => 'user_sessions#destroy', :as => :logout

  resources :users, only: %i[new create]
  resources :menus do
    resources :comments, only: %i[create], shallow: true
    collection do
      get :likes
    end
  end
  resources :likes, only: %i[create destroy]
end
