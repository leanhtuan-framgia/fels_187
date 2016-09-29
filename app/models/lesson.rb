class Lesson < ApplicationRecord
  belongs_to :category
  belongs_to :user
  enum status: [:init, :in_progress, :unchecked, :checked]

  has_many :results, dependent: :destroy

  before_create :build_result

  accepts_nested_attributes_for :results, allow_destroy: true

  def calculated_spent_time
    time = Time.zone.now - started_at
    time > Settings.duration ? Settings.duration : time
  end

  def time_out?
    unchecked? || Time.zone.now > started_at + Settings.duration
  end

  def remaining_time
    init? || in_progress? ? Settings.duration - (Time.zone.now - started_at)
      .to_i : 0
  end

  def update_time_status
    if init?
      update_attributes started_at: Time.zone.now, status: :in_progress
    elsif in_progress?
      update_attributes spent_time: calculated_spent_time
    end
  end

  private
  def build_result
    category.questions.shuffle().take(Settings.lesson_size).each do |question|
      self.results.build question_id: question.id
    end
  end
end
