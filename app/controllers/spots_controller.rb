class SpotsController < ApplicationController
  def index
    @spots = Spot.all
  end

  def new
    @spot = Spot.new
  end

  def create
    
    Spot.create(spot_params)
  end

  private

  def spot_params
    params.require(:spot).permit(:image, :title, :description).merge(user_id: current_user.id)
  end
  
end
