class Category < ApplicationRecord
  has_many :lessons, dependent: :destroy
  has_many :questions, dependent: :destroy
end
