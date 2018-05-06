require 'rails_helper'

RSpec.describe Api::V1::QuestionsController, type: :request do
  let(:tenant) { create(:tenant) }
  describe '#questions' do
    context 'with valid auth token' do
      before do
        create_list(:question, 5, :with_answers)
        auth_header = { Authorization: "Token #{tenant.api_key}" }
        get api_v1_questions_url, headers: auth_header
      end

      it 'returns questions with answers' do
        expect(response.status).to eq 200
        expect(response).to match_response_schema('questions')
      end

      it 'returns only public answers' do
        res = json[(0..json.length).to_a.sample]
        if res.dig('public_answers').first
          expect(res.dig('public_answers').first&.dig('is_personal')).to be_falsey
        end
      end
    end
    context 'with invalid token' do
      it 'returns authentication error' do
        get api_v1_questions_url
        expect(response.status).to eq 401
        expect(json['error']).to include('Invalid token')
      end
    end
  end

  describe '#search' do
    context 'with valid auth token' do
      let(:question) { create(:question) }
      before do
        create_list(:question, 5, :with_answers)
        @auth_header = { Authorization: "Token #{tenant.api_key}" }
      end

      context 'valid query' do
        before do
          get search_api_v1_questions_url, params: { query: question.description },
                                           headers: @auth_header
        end

        it 'returns questions and answers for valid query' do
          expect(response.status).to eq 200
          expect(response.body).to match_response_schema('questions')
          expect(json.count).not_to eq 0
        end

        it 'returns expected query result' do
          expect(json.any? { |s| s['description'] == question.description }).to be_truthy
        end
      end

      context 'invalid query' do
        before do
          get search_api_v1_questions_url, params: { query: 'empty' },
                                           headers: @auth_header
        end
        it 'returns questions and answers for valid query' do
          expect(response.status).to eq 200
          expect(response.body).to match_response_schema('questions')
          expect(json.count).to eq 0
        end
      end
      context 'no query parameter' do
        it 'should return error status' do
          get search_api_v1_questions_url, headers: @auth_header
          expect(response.status).to eq 400
        end
      end
    end
  end
end
