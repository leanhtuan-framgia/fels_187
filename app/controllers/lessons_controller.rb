class LessonsController < ApplicationController
  load_and_authorize_resource

  def create
    @lesson = current_user.lessons.new lesson_params
    if @lesson.save
      flash[:success] = t "flash.create_success"
      redirect_to @lesson.category
    else
      flash[:danger] = t "flash.create_fail"
      redirect_to :back
    end
  end

  def show
    @lesson.update_time_status
    @remaining_time = @lesson.remaining_time
  end

  def update
    @lesson.spent_time = @lesson.calculated_spent_time
    if @lesson.update_attributes lesson_params
      if params[:finish] || @lesson.time_out?
        @lesson.unchecked!
        flash[:success] = t "flash.completed_lesson"
      end
    else
      flash[:danger] = t "flash.finish_error"
    end
    redirect_to root_path
  end

  private
  def lesson_params
    params.require(:lesson).permit :category_id, :status, :spent_time, :score,
      {results_attributes: [:id, multiple_answers: []]}
  end
end
