class User < ApplicationRecord
  rolify
    has_secure_password
    has_many :turns
    
    validates :username, :password_digest, :name, :surname, :address, :email, presence: true, length: { maximum: 255 }

  def to_s
    "Nombre de usuario: #{username} | Rol: #{roles.first.name} | Nombre: #{name} | Apellido: #{surname} | Direccion: #{address} | Email: #{email} | Telefono: #{phone}"
  end
end
