Rails.application.routes.draw do
  put 'profile', to: 'profile#update'

  resources :contacts

  mount_devise_token_auth_for 'User', at: 'auth'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
