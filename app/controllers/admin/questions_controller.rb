class Admin::QuestionsController < Admin::BaseController
  load_and_authorize_resource
  before_action :load_params, only: [:new, :edit]

  def new
    @question.answers.build
  end

  def create
    if @question.save
      flash[:success] = t "flash.create_success"
      redirect_to admin_category_path @question.category
    else
      load_params
      render :new
    end
  end

  def edit
  end

  def update
    if @question.update_attributes question_params
      flash[:success] = t "flash.edit_success"
      redirect_to admin_category_path @question.category
    else
      load_params
      render :edit
    end
  end

  def destroy
    @category = @question.category
    if @question.destroy
      flash[:success] = t "flash.delete_success"
    else
      flash[:danger] = t "flash.delete_failed"
    end
    redirect_to admin_category_path @category
  end

  private
  def question_params
    params.require(:question).permit :content, :question_type, :category_id,
      answers_attributes: [:id, :question_id, :content, :is_correct, :_destroy]
  end

  def load_params
    @question_types = Question.question_types
  end
end
