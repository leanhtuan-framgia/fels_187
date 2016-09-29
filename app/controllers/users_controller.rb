class UsersController < ApplicationController
  load_and_authorize_resource

  def index
    @search = User.ransack params[:q]
    @users = @search.nil? ? @users : @search.result
    @users = @users.order(updated_at: :desc).paginate page: params[:page],
      per_page: Settings.size
  end

  def show
    @relationship = if current_user.following? @user
      current_user.active_relationships.find_by followed_id: @user.id
    else
      current_user.active_relationships.build
    end
    @activities = current_user.feeds.order(created_at: :desc).
      paginate page: params[:page], per_page: Settings.size
  end
end
