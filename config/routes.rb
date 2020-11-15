Rails.application.routes.draw do
  devise_for :users
  root to: 'homes#top'
  resources :spots
  get 'homes', to: 'homes#about'
end
