class CategoriesController < ApplicationController
  load_and_authorize_resource

  def index
    @search = Category.ransack params[:q]
    @categories = @search.nil? ? @categories : @search.result
    @categories = @categories.order(updated_at: :desc).paginate page: params[:page],
      per_page: Settings.size
  end
end
