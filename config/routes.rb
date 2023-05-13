Rails.application.routes.draw do
  resources :users, only: %i[index show] do
    resources :posts, only: %i[index show] do
      resources :comments, only: %i[new create]
      resources :likes, only: %i[create]
    end
  end
end
