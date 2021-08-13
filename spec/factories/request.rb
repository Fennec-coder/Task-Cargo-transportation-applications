require 'ffaker'

FactoryBot.define do
  factory :request do
    association :client

    origin_location {'44.59159641323023, 33.49119757358017'}
    destination { '44.59500905601948, 33.52912711278418' }
    distance { 4099 }

  end
end