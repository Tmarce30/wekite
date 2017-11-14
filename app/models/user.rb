class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :favorites
  has_many :reviews
  has_many :spots

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :age, presence: true
  validates :email, uniqueness: true, presence: true

  has_attachments :photos
end
