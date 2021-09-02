require 'rails_helper'

RSpec.describe Cargo, type: :model do
  it { is_expected.to belong_to(:request) }
end
