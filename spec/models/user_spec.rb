require 'rails_helper'

RSpec.describe User, type: :model do
  it 'has a valid factory' do
    expect(build(:user)).to be_valid
  end

  let(:user) { build(:user) }

  describe 'Validations' do
    it { expect(user).to validate_presence_of(:name) }
  end

  describe 'Associations' do
    it { expect(user).to have_many(:questions) }
    it { expect(user).to have_many(:answers) }
  end

end
