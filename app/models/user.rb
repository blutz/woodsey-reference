class User < ActiveRecord::Base
  validates :camp_name, :real_name, :email, presence: true
  validates :email, uniqueness: { case_sensitive: false }
  validates :email, email: true
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }
end
