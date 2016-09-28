class Admin::CategoriesController < Admin::BaseController
  load_and_authorize_resource

  def index
    @search = Category.ransack params[:q]
    @categories = @search.nil? ? @categories : @search.result
    @categories = @categories.order("updated_at DESC").
      paginate page: params[:page], per_page: Settings.size
  end

  def new
  end

  def create
    @category = Category.new category_params
    if @category.save
      flash[:success] = t "flash.create_success"
      redirect_to admin_categories_path
    else
      render :new
    end
  end

  def show
    @questions = if params[:search_name].present?
      Question.search_question @category.id, params[:search_name]
    else
      @category.questions
    end
    @questions = @questions.order(updated_at: :desc).
      paginate page: params[:page], per_page: Settings.size
  end

  def edit
  end

  def update
    if @category.update_attributes category_params
      flash[:success] = t "flash.edit_success"
      redirect_to admin_categories_path
    else
      render :edit
    end
  end

  def destroy
    if @category.destroy
      flash[:success] = t "flash.delete_success"
      redirect_to admin_categories_path
    else
      flash[:danger] = t "flash.delete_fail"
      redirect_to admin_categories_path
    end
  end

  private
  def category_params
    params.require(:category).permit :name, :description
  end
end
