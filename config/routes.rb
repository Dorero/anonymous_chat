Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check
  mount ActionCable.server => '/cable'

  root "chats#index"

  resources :chats, only: [:show, :index] do
    collection do
      post :search
    end
  end
end
