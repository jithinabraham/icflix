require 'rails_helper'

RSpec.describe Api::V1::QuestionsController, type: :request do
  describe '#questions' do
    let(:tenant) { create(:tenant) }
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
        expect(res.dig('public_answers').first&.dig('is_personal')).to be_falsey
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
end
