class User < ActiveRecord::Base
  attr_accessor :forgot_token

  has_many :session_users
  has_many :sessions, through: :session_users

  validates :camp_name, :real_name, :email, presence: true
  validates :email, uniqueness: { case_sensitive: false }
  validates :email, email: true
  has_secure_password
  # Don't actually allow nil password; has_secure_password will validate for that
  validates :password, length: { minimum: 6 }, allow_nil: true

  def forgot_password
    self.forgot_token = User.new_token
    update_attribute(:forgot_digest, User.digest(forgot_token))
  end

  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def User.new_token
    SecureRandom.urlsafe_base64(30)
  end
end
