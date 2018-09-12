class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit,
                                        :update, :destroy,
                                        :following, :followers]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: :destroy

  def index
    #@users = User.all
    @users = User.paginate(page: params[:page])
  end

  def new
  end

  def Show
    @current_user = current_user
    @videoposts = @current_user.videoposts.paginate(page: params[:page])
  end

  private

    def user_params
      params.require(:user).permit(
        :name, :email, :password,
        :password_confirmation)
    end

    # 正しいユーザーかどうか確認
    def correct_user
      # GET   /users/:id/edit
      # PATCH /users/:id
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end
