class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:sign_in, keys: [:name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  end


  private

    # ユーザーのログインを確認する
    def logged_in_user
      unless user_signed_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end
end
