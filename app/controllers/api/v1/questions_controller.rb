class Api::V1::QuestionsController < Api::V1::ApplicationController

  def index
    @questions = Question.includes(:asker, public_answers: :provider)
    render json: @questions, include: %w[asker public_answers public_answers.provider]
  end

  def search
    if params[:query]
      @questions = Question.includes(:asker, public_answers: :provider)
                           .where('description like :query', query: "%#{params[:query]}%")
      render json: @questions, include: %w[asker public_answers public_answers.provider]
    else
      send_error_response
    end
  end
end
