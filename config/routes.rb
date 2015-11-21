Rails.application.routes.draw do
  devise_for :users, controllers: {
    omniauth_callbacks: "users/omniauth_callbacks",
    registrations: "users/registrations",
  }
  devise_scope :user do
    get "users/sign_up_guide", to: "users/registrations#new_guide"
    get "users/sign_up_tourist", to: "users/registrations#new_tourist"
  end

  resources :tours, only: [:index, :show, :new, :create] do
    collection do
      post :search
    end
  end

  get "/get-the-guide", to: 'home#get_the_guide'
  root 'home#show'
end
