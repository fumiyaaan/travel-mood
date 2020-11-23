Rails.application.routes.draw do
  devise_for :users
  root to: 'homes#top'
  resources :spots do
    resources :comments, only: :create
  end
  get 'spots', to: 'spots#search'
  resources :users, only: :show
  get 'homes', to: 'homes#about'
end
