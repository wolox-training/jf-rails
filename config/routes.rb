Rails.application.routes.draw do
  api_version(module: 'api/v1', path: { value: 'api/v1' }, defaults: { format: :json }) do
    resources :books, only: [:index, :show]

    resources :users, only: [] do
      resource :rents, only: [:create, :show]
      get 'rents', to: 'rents#index'
    end

    resources :books, only: [] do
      get 'rents', to: 'rents#index'
    end
  end
  
  mount_devise_token_auth_for 'User', at: 'auth'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
