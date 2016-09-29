class LessonMailer < ApplicationMailer
  def remind_email lesson
    @user = lesson.user
    @lesson = lesson
    mail to: @user.email, subject: I18n.t("mail.remind_subject")
  end

  def lesson_finished_email lesson
    @user = lesson.user
    @lesson = lesson
    mail to: @user.email, subject: I18n.t("mail.result_subject")
  end

  def monthly_email user_id, question_count
    @question_count = question_count
    @user = User.find_by id: user_id
    mail to: @user.email, subject: I18n.t("mail.monthly_subject")
  end
end
