require 'rails_helper'

RSpec.describe Client, type: :model do
  subject { build(:client) }

  it { is_expected.to have_many(:request) }

  describe 'validations' do
    it { should validate_presence_of(:email) }
  end
end
