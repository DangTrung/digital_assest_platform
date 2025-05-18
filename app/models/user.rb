class User < ApplicationRecord
  extend Devise::Models
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum :role, { admin: 0, creator: 1, customer: 2 }

  has_many :assets, dependent: :destroy
  has_many :purchases, dependent: :destroy
  has_many :purchase_items, through: :purchases

  validates :email,
            presence: true,
            uniqueness: { case_sensitive: false },
            format: { with: Devise.email_regexp }
  validates :name, presence: true
end
