class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Token::ControllerMethods
  before_action :authorized

  def issue_token(payload)
    JWT.encode(payload, "coffeecodecoffeecode")
  end

  def current_user
    authenticate_or_request_with_http_token do |jwt_token, options|
      begin
        decoded_token = JWT.decode(jwt_token, "coffeecodecoffeecode")

      rescue JWT::DecodeError
        return nil
      end

      if decoded_token[0]["user_id"]
        @current_user ||= User.find(decoded_token[0]["user_id"])
        render json: {info: @current_user}
      else
        render json: {message: "Error: decoded token first element is not 'user_id'. From ApplicationController line 22"}
      end
    end
  end

  def logged_in?
    !!current_user
  end

  def authorized
    render json: {message: "Not welcome" }, status: 401 unless logged_in?
  end
end
