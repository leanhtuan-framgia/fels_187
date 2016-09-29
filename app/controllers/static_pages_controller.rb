class StaticPagesController < ApplicationController
  def home
    if user_signed_in?
      @activities = current_user.feeds.order(created_at: :desc).paginate page: params[:page],
        per_page: Settings.size
    end
  end
end
