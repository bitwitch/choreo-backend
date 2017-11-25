class Api::V1::UsersController < ApplicationController

  # def login 
  #   user = User.find_by(username: params[:username]) 
  #   if user && user.authenticate(params[:password])
  #     render json: user 
  #   else 
  #     render json: {message: "FUCKING EXPLOSION"}
  #   end
  # end  

  def index 
    users = User.all
    render json: users
  end 

  def show
    user = User.find(params[:id])
    render json: user 
  end 

  def create 
    user = User.new(user_params)
    if user.save
      render json: user 
    else
      render json: {message: "FUCKING EXPLOSION!"}
    end
  end   

  private 

  def user_params
    params.permit(:username, :password, :password_confirmation, :name, :age, :location, :photo)
  end

end 
