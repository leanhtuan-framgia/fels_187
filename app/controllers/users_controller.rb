class UsersController < ApplicationController
  load_and_authorize_resource

  def index
    @search = User.ransack params[:q]
    @users = @search.nil? ? @users : @search.result
    @users = @users.order(updated_at: :desc).paginate page: params[:page],
      per_page: Settings.size
  end

  def show
  end
end
