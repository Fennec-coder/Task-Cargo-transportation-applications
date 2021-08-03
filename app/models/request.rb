class Request < ApplicationRecord
  has_many :cargo
  belongs_to :client
end
