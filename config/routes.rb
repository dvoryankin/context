Rails.application.routes.draw do
  root to: 'sessions#new'

  get 'login' => 'sessions#new'
  get 'logout' => 'session#destroy'
  get 'signup' => 'users#new'

  resources :sessions, only: %i[new create destroy]
  resources :users
  resources :tasks, only: %i[index new create]
end
