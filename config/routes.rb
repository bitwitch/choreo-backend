Rails.application.routes.draw do
 namespace :api do
  namespace :v1 do
    resources :users, only: [:create, :show, :index]
    resources :choreographies, only: [:create, :show, :index]
  end
 end 
end
