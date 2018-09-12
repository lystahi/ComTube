class StaticPagesController < ApplicationController
  def home
    if user_signed_in?
      @videopost  = current_user.videoposts.build
      @feed_items = current_user.feed.paginate(page: params[:page])
    end
  end

  def help
  end
end
