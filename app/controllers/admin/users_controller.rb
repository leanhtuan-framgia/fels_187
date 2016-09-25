class Admin::UsersController < Admin::BaseController
  load_and_authorize_resource

  def index
    @search = User.ransack params[:q]
    @users = @search.nil? ? @users : @search.result
    @users = @users.order(updated_at: :desc).paginate page: params[:page],
      per_page: Settings.size
  end

  def new
  end

  def create
    if @user.save
      flash[:success] = t "flash.create_user_success"
      redirect_to admin_root_path
    else
      render :new
    end
  end

  def destroy
    @user.destroy
    respond_to do |format|
      format.html {redirect_to admin_users_path, notice: t("flash.delete_user")}
      format.js
    end
  end

  private
  def user_params
    params.require(:user).permit :name, :email, :password,
      :password_confirmation
  end
end
