class Result < ApplicationRecord
  belongs_to :answer
  belongs_to :question
  belongs_to :lesson

  serialize :multiple_answers

  scope :result_correct, ->{where state: true}

  def update_state
    if question.text?
      if (multiple_answers && multiple_answers.first.to_s.casecmp(question
        .answers.first.content) == 0)
        state = true
      end
    else
      if multiple_answers.size == count_correct_answer
        state = true
        multiple_answers.collect.each do |id|
          unless question.answers.find_by(id: id).is_correct
            update_attributes state: false
            return
          end
        end
      end
      state = false
    end
    update_attributes state: state if state
  end

  private
  def count_correct_answer
    question.answers.answer_corrects.size
  end
end
