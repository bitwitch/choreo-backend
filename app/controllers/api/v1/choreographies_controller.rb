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
    
  end 

end