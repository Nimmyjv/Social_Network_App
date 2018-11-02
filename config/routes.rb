Rails.application.routes.draw do
  resources :comments
  resources :photos do
  	member do
  		get :toggle_like
      resources :comments
  	end
  end
  get 'home/index'
  devise_for :users

  root to: "home#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
