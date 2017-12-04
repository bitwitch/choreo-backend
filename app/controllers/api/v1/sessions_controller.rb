require 'base64'

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

  # def wait_for_spotify
  #   if (@@access_token && @@refresh_token)
  #     current_user.update(access_token: @@access_token, refresh_token: @@refresh_token)
  #     a_token = @@access_token 
  #     r_token = @@refresh_token 
  #     @@access_token  = false 
  #     @@refresh_token = false
  #     render json: {access_token: a_token, refresh_token: r_token}
  #   else 
  #     render json: {tokens_received: false}
  #   end 
  # end

  # def spotify 
  #   if params[:error] 
  #     render json: {error: params[:error]}
  #   else 
  #     encoded_secrets = Base64.strict_encode64("d59d3b99ecf54e6b8fbff1da8c7f11c6:861625e443824414bc9e9a576d9689be")
  #     response = RestClient.post("https://accounts.spotify.com/api/token", {grant_type: "authorization_code", code: params[:code], redirect_uri: "http://localhost:3000/api/v1/auth/spotify/callback/"}, {Authorization: "Basic #{encoded_secrets}"})
  #     json = JSON.parse(response.body)
  #     @@access_token  = json["access_token"]
  #     @@refresh_token = json["refresh_token"]
  #     current_user 
  #     render json: {success: 'Successfully signed in! You may now close this tab.'}
  #   end 
  # end 

  # def refresh 

  # end 

end