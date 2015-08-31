class Session < ActiveRecord::Base
  has_many :session_users
  has_many :users, through: :session_users

  validates :name, presence: true
end
