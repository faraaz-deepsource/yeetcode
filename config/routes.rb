Rails.application.routes.draw do
  resources :problems do
    resources :solutions
  end

  devise_for :users

  root to: 'problems#index'
end
