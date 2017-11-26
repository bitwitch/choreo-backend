Rails.application.routes.draw do
 namespace :api do
  namespace :v1 do
    resources :users, only: [:create, :show, :index]
    resources :choreographies, only: [:create, :show, :index]
    post '/login', to: 'sessions#create'
    get '/current_user', to: 'sessions#get_current_user'
  end
 end 
end
