class Answer < ApplicationRecord
  belongs_to :provider, class_name: 'User', foreign_key: :user_id, inverse_of: :answers
  belongs_to :question, inverse_of: :answers
end
