class Answer < ApplicationRecord
  belongs_to :question, optional: true

  validates :content, presence: true
end
