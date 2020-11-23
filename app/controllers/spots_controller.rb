class SpotsController < ApplicationController
  before_action :authenticate_user!, except: :index
  before_action :set_spot, only: [:show, :edit, :update, :destroy]
  before_action :move_to_index, only: :edit

  def index
    @spots = Spot.all.order('created_at DESC')
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
    @comment = Comment.new
    @comments = @spot.comments.includes(:user)
    @unknown = @spot.comments.average(:unknown)
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

  def destroy
    if user_signed_in? && current_user.id == @spot.user_id
      @spot.destroy
      redirect_to spots_path
    else
      redirect_to spot_path(@spot.id)
    end
  end

  def search
    @spots = Spot.search(params[:keyword])
  end

  private

  def spot_params
    params.require(:spot).permit(:image, :title, :description).merge(user_id: current_user.id)
  end

  def set_spot
    @spot = Spot.find(params[:id])
  end

  def move_to_index
    redirect_to action: :index unless user_signed_in? && current_user.id == @spot.user_id
  end
end
