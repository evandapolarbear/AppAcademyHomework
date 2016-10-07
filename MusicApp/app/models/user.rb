class User < ApplicationRecord
  validates :email, presence: true, uniqueness: true
  validates :session_token, presence: true, uniqueness: true
  validates :password_digest, presence: true

  after_initialze :ensure_session_token

  def self.find_user_by_credentials(username, password)
    user = User.find_by(username: username)
    if user
      return user if user.is_password?(user)
    end
    nil
  end

  def self.generate_session_token
    SecureRandom.urlsafe_base64
  end

  def reset_session_token!
    self.session_token = User.generate_session_token
    self.save!
  end

  def ensure_session_token
    @session_token ||= self.sesssion_token = SecureRandom.urlsafe_base64
  end

  def password=(password)
    self.password_digest = BCrypt::Password.create(password)
    self.save!
  end

  def is_password?(password)
    temp = BCrypt::Password.new(self.password_digest)
    temp.is_password(password)
  end

  def landing
    render :landing
  end
end
