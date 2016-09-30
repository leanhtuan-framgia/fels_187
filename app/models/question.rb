class Question < ApplicationRecord
  belongs_to :category

  has_many :answers, dependent: :destroy
  has_many :results, dependent: :destroy

  validates :content, presence: true
  validate :check_correct_answer

  accepts_nested_attributes_for :answers, allow_destroy: true

  enum question_type: [:single_choice, :multiple_choice, :text]

  scope :search_question, ->category_id, name{where "category_id = #{category_id}
    AND content LIKE '%#{name}%'"}
  scope :learned, ->user_id{joins(results: :lesson).where(lessons:{user_id: user_id,
    status: 2, created_at: (Time.now-1.month .. Time.now)}).size}

  private
  def check_correct_answer
    unless self.text?
      correct_answer = answers.select {|answer| answer.is_correct?}
      errors.add :correct_answer,
        I18n.t("notification.must_check") if correct_answer.empty?
    end
  end
end
