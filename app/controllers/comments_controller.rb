class CommentsController < ApplicationController
  def create
    @spot = Spot.find(params[:spot_id])
    @comment = Comment.new(comment_params)
    if @comment.save
      redirect_to spot_path(@spot.id)
    else
      @spot = Spot.find(params[:spot_id])
      @comments = @spot.comments.includes(:user)
      render 'spots/show'
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text, :unknown).merge(user_id: current_user.id, spot_id: params[:spot_id])
  end
  
end
