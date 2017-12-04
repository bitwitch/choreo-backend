require 'base64'

class Api::V1::UsersController < ApplicationController
  skip_before_action :authorized, only: [:create, :spotify]

  @@access_token  = false 
  @@refresh_token = false

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

  def wait_for_spotify
    if (@@access_token && @@refresh_token)
      a_token = @@access_token 
      r_token = @@refresh_token 
      @@access_token  = false 
      @@refresh_token = false
      render json: {access_token: a_token, refresh_token: r_token}
    else 
      render json: {tokens_received: false}
    end 
  end

  def spotify 
    if params[:error] 
      render json: {error: params[:error]}
    else 
      encoded_secrets = Base64.strict_encode64("d59d3b99ecf54e6b8fbff1da8c7f11c6:861625e443824414bc9e9a576d9689be")
      response = RestClient.post("https://accounts.spotify.com/api/token", {grant_type: "authorization_code", code: params[:code], redirect_uri: "http://localhost:3000/api/v1/auth/spotify/callback/"}, {Authorization: "Basic #{encoded_secrets}"})
      json = JSON.parse(response.body)
      @@access_token  = json["access_token"]
      @@refresh_token = json["refresh_token"]
      render json: {success: 'Successfully signed in! You may now close this tab.'}
    end 

  end 

  private 

  def user_params
    params.permit(:username, :password, :password_confirmation, :name, :age, :location, :photo)
  end

end 
