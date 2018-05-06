class QuestionSerializer < ActiveModel::Serializer
  attributes :id, :description
  has_many :answers
  has_many :public_answers
  belongs_to :asker
end
