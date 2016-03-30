Rails.application.routes.draw do
  root "static_pages#home"

  devise_for :users

  resources :questions, except: [:index, :show]

  namespace :admin do
    root "categories#index"
    resources :categories
    resources :questions, except: [:show]
    resources :users 
  end
end
