Rails.application.routes.draw do
  devise_for :users
  root to: 'homes#top'
  resources :spots, only: [:index, :new, :create]
  get 'homes', to: 'homes#about'
end
