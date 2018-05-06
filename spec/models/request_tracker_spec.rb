require 'rails_helper'

RSpec.describe RequestTracker, type: :model do
  it 'has valid factory' do
    expect(build(:request_tracker)).to be_valid
  end

  let(:request_tracker) { create(:request_tracker) }

  describe 'Validations' do
    it { expect(request_tracker).to validate_presence_of(:date) }
  end

  describe 'Associations' do
    it { expect(request_tracker).to belong_to(:tenant) }
  end

  describe 'Public methods' do
    context 'responds to its methods' do
      it { expect(request_tracker).to respond_to(:track!) }
    end

    context 'executes methods correctly' do
      describe '#track!' do
        it 'increases the request count' do
          request_count = request_tracker.request_count
          request_tracker.track!
          expect(request_tracker.request_count).to eq(request_count + 1)
        end
      end
    end
  end
end
