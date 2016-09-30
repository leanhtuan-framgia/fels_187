class LessonWorker
  include Sidekiq::Worker

  sidekiq_options retry: false

  START_EXAM = 1
  FINISH_EXAM = 2

  def perform lesson_id, action
    lesson = Lesson.find_by id: lesson_id
    case action
    when START_EXAM
      LessonMailer.remind_email(lesson).deliver
    when FINISH_EXAM
      LessonMailer.lesson_finished_email(lesson).deliver_now
    end
  end
end
