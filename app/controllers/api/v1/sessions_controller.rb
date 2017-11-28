class Api::V1::SessionsController < ApplicationController
  skip_before_action :authorized, only: [:create, :signup]

  def show
    render json: {
      id: current_user.id,
      username: current_user.username
    }
  end

  def get_current_user 
    user = current_user
    if user 
      render json: {info: user, friends: user.friends, choreographies: user.choreographies, likes: user.likes}
    else 
      render json: {error: "no user currently logged in"}
    end 
  end 

  def signup 
    create
  end 

  def create
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      payload = {user_id: user.id}
      token = issue_token(payload)
      render json: { jwt: token, info: user, friends: user.friends, choreographies: user.choreographies, likes: user.likes }
    else
      render json: { error: "some bad stuff happened"}
    end
  end
end