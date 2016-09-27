class Admin::StaticPagesController < Admin::BaseController
  def index
  end

  alias_method :home, :index
end
