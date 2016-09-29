class Answer < ApplicationRecord
  belongs_to :question, optional: true

  validates :content, presence: true

  scope :answer_corrects, ->{where is_correct: true}
end
