class Api::V1::UsersController < ApplicationController
  skip_before_action :authorized, only: [:create]

  def index 
    users = User.all
    render json: users
  end 

  def show
    user = User.find(params[:id])
    render json: {info: user, choreographies: user.choreographies}
  end 

  def create 
    user = User.new(user_params)
    if user.save
      redirect_to api_v1_signup_url(username: params[:username], password: params[:password])
    else
      render json: {error: "Error: Invalid Sign Up information"}
    end
  end   

  private 

  def user_params
    params.permit(:username, :password, :password_confirmation, :name, :age, :location, :photo)
  end

end 
