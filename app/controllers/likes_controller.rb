class LikesController < ApplicationController
  before_action :user_signed_in?

  def create
    @like = Like.new(user_id: current_user.id, videopost_id: params[:videopost_id])
    @like.save
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @like = Like.find_by(user_id: current_user.id, videopost_id: params[:videopost_id])
    @like.destroy
    redirect_back(fallback_location: root_path)
  end
end
