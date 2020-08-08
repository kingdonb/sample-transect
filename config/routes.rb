Rails.application.routes.draw do
  root to: 'regions#index'
  get '/regions', to: 'regions#index'
  get '/regions/:id', to: 'regions#show'
end
