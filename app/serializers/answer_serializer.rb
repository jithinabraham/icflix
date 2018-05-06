class AnswerSerializer < ActiveModel::Serializer
  attributes :id, :description, :is_personal
  belongs_to :provider
end
