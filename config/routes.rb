Rails.application.routes.draw do
  devise_for :users, controllers: {
        sessions: 'users/sessions'
      }
  root 'static_pages#home'
  get  '/help',    to: 'static_pages#help'
  get  '/about',   to: 'static_pages#about'
  get  '/contact', to: 'static_pages#contact'
  get  '/signup',  to: 'users#new'
  resources :users do
    member do
      get :following, :followers
    end
  end

  resources :videoposts, only:[:create, :destroy]
  resources :relationships,       only: [:create, :destroy]

  get "users/:id/likes", to: "users#likes"
  post "likes/:videopost_id/create" => "likes#create"
  post "likes/:videopost_id/destroy" => "likes#destroy"
end
