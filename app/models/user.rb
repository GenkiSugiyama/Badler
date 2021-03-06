class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, uniqueness: true

  enum sex: { not_selected: 0, male: 1, female: 2 }

  has_many :entries, dependent: :destroy
  has_many :messages, dependent: :destroy
  has_many :club_menbers, dependent: :destroy
  has_many :clubs, through: :club_menbers
  has_many :entry_users, dependent: :destroy
end
