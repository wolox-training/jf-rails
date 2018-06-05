class User < ApplicationRecord
  include DeviseTokenAuth::Concerns::User

  has_many :rents, dependent: :destroy

  # Include devise modules
  devise :database_authenticatable, :registerable, :recoverable,
         :rememberable, :trackable, :validatable, :confirmable
end
