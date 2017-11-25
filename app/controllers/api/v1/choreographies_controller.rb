class Api::V1::ChoreographiesController < ApplicationController
  
  def index 
    choreographies = Choreography.all 
    render json: choreographies
  end 

  def show
    choreography = Choreography.find(params[:id])
    render json: choreography
  end 

  def create 
    choreography = Choreography.new(choreography_params)
    if choreography.save
      render json: choreography 
    else
      render json: {message: "Error: invalid format for choreography, #{choreography.errors.full_messages}"}
    end
  end 

  private 

  def choreography_params 
    params.permit(:user_id, :poses_json)
  end 

end