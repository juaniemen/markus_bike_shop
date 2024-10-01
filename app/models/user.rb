class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable 
  # :registerable, :recoverable, :rememberable, :validatable

  validates :username, 
    length: { minimum: 6, maximum: 50 }, 
    presence: true, 
    uniqueness: true, 
    format: { with: /\A[a-zA-Z0-9]+\z/ }
end
