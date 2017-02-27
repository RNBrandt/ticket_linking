Rails.application.routes.draw do
  scope '/api' do
    scope '/v1' do
      resources :accounts, only: [:show]
      resources :tickets do
        get :related
        get :incidents
      end
    end
  end

  root 'api#index'
end
