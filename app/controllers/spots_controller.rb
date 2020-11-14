class SpotsController < ApplicationController
  before_action :authenticate_user!, except: :index

  def index
    @spots = Spot.all
  end

  def new
    @spot = Spot.new
  end

  def create
    @spot = Spot.new(spot_params)
    if @spot.save
      redirect_to spots_path
    else
      render :new
    end
  end

  private

  def spot_params
    params.require(:spot).permit(:image, :title, :description).merge(user_id: current_user.id)
  end
end
