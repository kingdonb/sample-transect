Rails.application.routes.draw do

  # authorization with auth0
  get 'auth/auth0/callback' => 'auth0#callback'
  get 'auth/failure' => 'auth0#failure'

  get '/logout' => 'logout#logout'

  resources :alumnis
  root to: 'regions#index'
  get '/regions', to: 'regions#index'
  get '/regions/:id', to: 'regions#show'

  get '/healthz', to: proc { [200, {}, ['']] }
end
