Rails.application.routes.draw do
  devise_for :users
  root to: 'homes#top'
  resources :spots do
    resources :comments, only: :create
    collection do
      get 'search'
    end
  end
  resources :users, only: :show
  get 'homes', to: 'homes#about'
end
