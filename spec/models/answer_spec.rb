require 'rails_helper'

RSpec.describe Answer, type: :model do
  it 'has a valid factory' do
    expect(build(:answer)).to be_valid
  end

  let(:answer) { build(:answer) }

  describe 'Validations' do
    it { expect(answer).to validate_presence_of(:description) }
  end

  describe 'Associations' do
    it { expect(answer).to belong_to(:question) }
    it { expect(answer).to belong_to(:provider) }
  end
end
