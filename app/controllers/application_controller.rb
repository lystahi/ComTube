class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  before_action :logged_in_user, only: [:create]

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:sign_in, keys: [:name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  end

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

end
