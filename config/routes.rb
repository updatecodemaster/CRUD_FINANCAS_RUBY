Rails.application.routes.draw do
  root "processos#index"

  resources :processos

  get "up" => "rails/health#show", as: :rails_health_check
end
