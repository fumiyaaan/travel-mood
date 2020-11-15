class SpotsController < ApplicationController
  before_action :authenticate_user!, except: :index
  before_action :set_spot, only: [:show, :edit, :update]

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

  def show
  end

  def edit
  end

  def update
    if @spot.update(spot_params)
      redirect_to spot_path(@spot.id)
    else
      render :edit
    end
  end

  private

  def spot_params
    params.require(:spot).permit(:image, :title, :description).merge(user_id: current_user.id)
  end

  def set_spot
    @spot = Spot.find(params[:id])
  end
end
