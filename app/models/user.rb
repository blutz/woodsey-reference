class User < ActiveRecord::Base
  has_many :session_users
  has_many :sessions, through: :session_users

  validates :camp_name, :real_name, :email, presence: true
  validates :email, uniqueness: { case_sensitive: false }
  validates :email, email: true
  has_secure_password
  # Don't actually allow nil password; has_secure_password will validate for that
  validates :password, length: { minimum: 6 }, allow_nil: true
end
