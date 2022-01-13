Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'restaurants#index'
  resources :restaurants, only: [ :index, :new, :create, :show ] do
    # reviews don't need to go to members cause review is not a field of restaurant
    resources :reviews, only: [ :new, :create ]
  end
end
