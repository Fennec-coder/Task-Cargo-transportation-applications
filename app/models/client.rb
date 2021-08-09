class Client < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :request, dependent: :delete_all

  validates :email, :name, :surname, :patronymic, :phone_number, :password, :presence => true

end
