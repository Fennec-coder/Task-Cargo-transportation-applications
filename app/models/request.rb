class Request < ApplicationRecord
  has_many :cargo, dependent: :delete_all
  belongs_to :client
end
