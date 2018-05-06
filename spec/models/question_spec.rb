require 'rails_helper'

RSpec.describe Question, type: :model do
  it 'has a valid factory' do
    expect(build(:question)).to be_valid
  end

  let(:question) { build(:question) }

  describe 'Validations' do
    it { expect(question).to validate_presence_of(:description) }
  end

  describe 'Associations' do
    it { expect(question).to belong_to(:asker) }
    it { expect(question).to have_many(:answers) }
    it { expect(question).to have_many(:public_answers) }
  end

end
