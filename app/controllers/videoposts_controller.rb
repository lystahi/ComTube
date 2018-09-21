class VideopostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy

  def create
    @videopost = current_user.videoposts.build(videopost_params)
    if @videopost.save
      flash[:success] = "Videopost created!"
      redirect_to root_url
    else
      @feed_items = []
      render 'static_pages/home'
    end
  end

  def show
    @videopost = Videopost.find_by(id: params[:id])
    @user = @videopost.user
    @likes_count = Like.where(videopost_id: @videopost.id).count
  end


  def destroy
    @videopost.destroy
    flash[:success] = "Videopost deleted"
    redirect_to request.referrer || root_url
  end

  private

    # ユーザーのログインを確認する
    def logged_in_user
      unless user_signed_in?
        #store_location
        flash[:danger] = "Please log in."
        redirect_to new_user_session_path
      end
    end

    def videopost_params
      params.require(:videopost).permit(:content)
    end

    def correct_user
      @videopost = current_user.videoposts.find_by(id: params[:id])
      redirect_to root_url if @videopost.nil?
    end
end
