Rails.application.routes.draw do
  get 'dashboard/index'
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :questions, only: %w[index] do
        get :search, on: :collection
      end
    end
  end

  root to:'dashboard#index'
end
