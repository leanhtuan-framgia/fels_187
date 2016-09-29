class Result < ApplicationRecord
  belongs_to :answer
  belongs_to :question
  belongs_to :lesson

  serialize :multiple_answers
end
