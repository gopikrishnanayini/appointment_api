class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook, :google_oauth2]
  before_save :encrypt_password
  after_save :clear_password
  before_create :ensure_authentication_token, :generate_key 

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.password = Devise.friendly_token[0,20]
      if ["facebook", "google_oauth2"].include?(auth.provider)
        user.save(:validate => false)
      else
        user.email = auth.info.email
        user.save
      end
    end
  end

  def encrypt_password
	  if password.present?
	    self.salt = BCrypt::Engine.generate_salt
	    self.encrypted_password= BCrypt::Engine.hash_secret(password, salt)
	  end
	end

	def clear_password
	  self.password = nil
	end

	def generate_key
    self.key = Digest::SHA1.hexdigest(BCrypt::Engine.generate_salt)
    self.assign_secret_key
  end

  def assign_secret_key
    self.secret_key = self.get_secret_key
  end

  def ensure_authentication_token
    if authentication_token.blank?
      self.authentication_token = self.generate_authentication_token
    end
  end

  def get_secret_key
    Digest::SHA1.hexdigest(self.email.to_s + self.encrypted_password.to_s + self.key)
  end

  def generate_authentication_token
    loop do
      token = Devise.friendly_token
      break token unless User.where(authentication_token: token).first
    end
  end
end
