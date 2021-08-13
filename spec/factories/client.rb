require 'ffaker'
# This will guess the Client class
FactoryBot.define do
  factory :client do
    name { FFaker::Name.name }
    surname { FFaker::Name.name }
    patronymic { FFaker::Name.name }
    phone_number {FFaker::PhoneNumber}
    email { FFaker::Internet.email }
    password { 'password' }
    password_confirmation { 'password' }
  end
end