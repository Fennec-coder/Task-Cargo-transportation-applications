require 'ffaker'

FactoryBot.define do
  factory :cargo do
    association :request

    weight { FFaker::Random.rand(0..20) }
    length { FFaker::Random.rand(0..20) }
    width { FFaker::Random.rand(0..20) }

    height { FFaker::Random.rand(0..100) }

  end
end