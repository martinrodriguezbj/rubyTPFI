class User < ApplicationRecord
  rolify
    has_secure_password
    
    validates :username, :password_digest, presence: true, length: { maximum: 255 }
end
