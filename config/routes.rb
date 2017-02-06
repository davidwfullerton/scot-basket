Rails.application.routes.draw do
  root 'baskets#new'

  resources :baskets, only: [:new, :create, :edit, :update]
end
