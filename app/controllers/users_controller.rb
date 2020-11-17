class UsersController < ApplicationController
  def show
    user = User.find(params[:id])
    @name = user.name
    @profile = user.profile
    @spots = user.spots
  end

  def edit
  end

  def update
  end
end
