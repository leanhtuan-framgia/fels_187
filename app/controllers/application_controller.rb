class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  rescue_from CanCan::AccessDenied do |exception|
    flash[:danger] = t "flash.not_admin"
    redirect_to root_url
  end

  private
  def current_ability
    namespace = controller_path.split("/").first
    Ability.new current_user, namespace
  end

  def after_sign_in_path_for current_user
    current_user.is_admin? ? admin_root_path : root_path
  end
end
