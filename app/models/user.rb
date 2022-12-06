class User < ApplicationRecord
  rolify
    has_secure_password
    has_many :turns
    
    validates :username, :password_digest, presence: true, length: { maximum: 255 }

  def to_s
    string="Nombre de usuario: #{username}"
  end
end
