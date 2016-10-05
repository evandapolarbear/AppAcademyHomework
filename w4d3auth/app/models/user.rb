class User < ApplicationRecord
  validates :username, :password_digest, :session_token, presence: true

  def self.find_by_credentials(username, password)
    u = User.find_by(username: username)
    p = Bcrypt::Password.new(u.password_digest.to_s)
    up = Bcrypt::Password.is_password(p)

    if p
        return u
    end

    nil
  end

  def self.generate_session_token
     SecureRandom::urlsafe_base64(16)
  end

  def reset_session_token!
    self.session_token = User.generate_session_token
    self.save!
    self.session_token
  end

  def ensure_session_token
    self.session_token ||= User.generate_session_token
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end
end
