class MonthlyWorker
  include Sidekiq::Worker

  def perform user_id, question_count
    LessonMailer.monthly_email(user_id, question_count).deliver_now
  end
end
