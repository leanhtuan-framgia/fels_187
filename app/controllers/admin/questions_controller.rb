class Admin::QuestionsController < Admin::BaseController
  load_and_authorize_resource
  before_action :load_params, only: :new

  def new
    @question.answers.build
  end

  def create
    if @question.save
      flash[:success] = t "flash.create_success"
      redirect_to admin_questions_path @question
    else
      load_params
      render :new
    end
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
