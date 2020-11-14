Rails.application.routes.draw do
  devise_for :users
  root to: 'homes#top'
  resources :spots, only: [:index, :new, :create, :show]
  get 'homes', to: 'homes#about'
end
