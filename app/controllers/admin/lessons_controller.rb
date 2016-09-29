class Admin::LessonsController < Admin::BaseController
  load_and_authorize_resource
  skip_load_resource only: :edit

  def index
    @lessons.where(status: :in_progress).each do |lesson|
      lesson.update_time_status
    end
    @lessons = @lessons.paginate page: params[:page],
      per_page: Settings.size
  end

  def edit
    @lesson = Lesson.includes(results: [question: :answers])
      .find_by id: params[:id]
    @lesson.results.each do |result|
      result.update_state
    end
  end

  def update
    if @lesson.update_attributes lesson_params
      @lesson.update_attributes score: @lesson.results.result_correct.count
      flash[:success] = t "flash.edit_success"
    else
      flash[:danger] = t "flash.edit_error"
    end
    redirect_to admin_lessons_path
  end

  private
  def lesson_params
    params.require(:lesson).permit :status, :score,
      results_attributes: [:id, :state]
  end
end
