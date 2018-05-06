require 'rails_helper'

RSpec.describe Tenant, type: :model do
  it 'has a valid factory' do
    expect(build(:tenant)).to be_valid
  end

  let(:tenant) { build(:tenant) }

  describe 'Validations' do
    it { expect(tenant).to validate_presence_of(:name) }
    it { expect(tenant).to validate_presence_of(:api_key) }
    it { expect(tenant).to validate_uniqueness_of(:api_key) }
  end

  describe 'Associations' do
    it { expect(tenant).to have_many(:request_trackers) }
    it { expect(tenant).to have_one(:daily_tracker) }
  end

  context 'Callbacks' do
    let(:tenant) { create(:tenant) }

    it { expect(tenant).to callback(:generate_api_key).before(:create) }
  end

  describe 'public methods' do

    context 'responds to its methods' do
      it { expect(tenant).to respond_to(:request_track!) }
    end

    context 'executes methods correctly' do
      let(:tenant) { create(:tenant) }

      describe '#request_trackers!' do
        it 'does creates daily_tracker' do
          tenant.request_track!
          expect(tenant.daily_tracker).not_to be_nil
        end

        it 'does increase the request count' do
          tenant.request_track!
          tenant.request_track!
          expect(tenant.daily_tracker.request_count).to eq(2)
        end
      end
    end
  end

  describe 'private methods' do
    context 'executes method correctly' do
      describe '#generate_api_key' do
        it 'does creates api key' do
          tenant.api_key = nil
          tenant.send(:generate_api_key)
          expect(tenant.api_key).not_to be_nil
        end

        it 'does create uniq api_keys' do
          api_key = tenant.api_key
          tenant.api_key = nil
          tenant.send(:generate_api_key)
          expect(tenant.api_key).not_to eq(api_key)
        end
      end
    end
  end
end
