class RelationshipsController < ApplicationController
  load_and_authorize_resource

  def index
    @user = User.find_by id: params[:user_id]
    if @user.nil?
      flash[:danger] = t "flash.user_nil"
      redirect_to root_path
    else
      @relationship = params[:type]
      @users = @user.send(@relationship).paginate page: params[:page],
        per_page: Settings.size
    end
  end

  def create
    @user = User.find_by id: params[:followed_id]
    unless current_user.following? @user
      current_user.follow @user
    end
    @relationship = current_user.active_relationships.
      find_by followed_id: @user.id
    respond_to do |format|
      format.js do
        render json: {
          number: @user.followers.count,
          partial: render_to_string("users/_unfollow", layout: false)
        }
      end
    end
  end

  def destroy
    @relationship = Relationship.find_by id: params[:id]
    respond_to do |format|
      unless @relationship.nil?
        @user = @relationship.followed
        current_user.unfollow @user
        @relationship = current_user.active_relationships.build
        format.js do
          render json: {
            number: @user.followers.count,
            partial: render_to_string("users/_follow", layout: false)
          }
        end
      end
    end
  end
end
