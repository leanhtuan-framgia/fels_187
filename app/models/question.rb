class Question < ApplicationRecord
  belongs_to :category

  has_many :answers, dependent: :destroy
  has_many :results, dependent: :destroy
end
