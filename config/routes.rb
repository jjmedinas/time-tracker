Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root "api/v1/sessions#new"
  get "dashboard", to: "api/v1/sessions#new"

  namespace :api do
    namespace :v1 do
      resources :users

      post "sessions", to: "sessions#create"
      delete "sessions", to: "sessions#destroy"

      get 'users/:user_id/activity_logs/current', to: "activity_logs#current", as: :activity_logs_current
      post 'users/:user_id/activity_logs/current/check_in', to: "activity_logs#check_in", as: :activity_logs_check_in
      post 'users/:user_id/activity_logs/current/check_out', to: "activity_logs#check_out", as: :activity_logs_check_out
    end
  end
end
