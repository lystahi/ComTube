class RelationshipsController < ApplicationController
  before_action :logged_in_user

  def create
    @user = User.find(params[:followed_id])
    current_user.follow(@user)
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end

  def destroy
    @user = Relationship.find(params[:id]).followed
    current_user.unfollow(@user)
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
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
end
