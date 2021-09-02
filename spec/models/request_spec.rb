require 'rails_helper'

RSpec.describe Request, type: :model do
  it { is_expected.to belong_to(:client) }

  it { is_expected.to have_many(:cargo) }
end
