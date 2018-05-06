class Question < ApplicationRecord
  belongs_to :asker, class_name: 'User', foreign_key: :user_id, inverse_of: :questions
  has_many :answers
  has_many :public_answers, -> { where(is_personal: false) },
           class_name: 'Answer', inverse_of: :question

  validates :description, presence: true
end
