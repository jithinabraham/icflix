class Api::V1::QuestionsController < Api::V1::ApplicationController

  def index
    @questions = Question.includes(:asker, public_answers: :provider)
    render json: @questions, include: %w[asker public_answers public_answers.provider]
  end
end
