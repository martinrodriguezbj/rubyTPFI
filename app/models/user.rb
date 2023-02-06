class User < ApplicationRecord
  rolify
    has_secure_password
    has_many :turns
    
    validates :username, :name, :surname, :address, :email, presence: true, length: { maximum: 255 }
    validate :passswordValidate, :nameValidate, :surnameValidate, :emailValidate, :phoneValidate, :addressValidate, :usernameValidate

  def to_s
    "Nombre de usuario: #{username} | Rol: #{roles.first.name} | Nombre: #{name} | Apellido: #{surname} | Direccion: #{address} | Email: #{email} | Telefono: #{phone}"
  end

  #verificar que la contraseña sea segura
  def passswordValidate
    if password.present? && !password.match(/^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)./)
      errors.add(:password, "must contain at least one lowercase letter, one uppercase letter and one digit")
    end
  end

  #username no puede repetirse entre los usuarios y el username no es el del actual usuario
  def usernameValidate
    if username.present? && User.where(username: username).any? && User.where(username: username).first.id != id
      errors.add(:username, "must be unique")
    end
  end  

  #verificar que el name y surname sean solo letras
  def nameValidate
    if name.present? && !name.match(/^[a-zA-Z\s]+$/)
        errors.add(:name, "must contain only letters and spaces")
    end
  end

  def surnameValidate
    if surname.present? && !surname.match(/^[a-zA-Z\s]+$/)
      errors.add(:surname, "must contain only letters and spaces")
  end
  end

  #verificar que el email sea valido
  def emailValidate
    if email.present? && !email.match(/\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i)
      errors.add(:email, "must be valid")
    end
  end

  #verificar que el telefono sea valido
  def phoneValidate
    if phone.present? && !phone.match(/^[0-9]+$/)
      errors.add(:phone, "must contain only numbers")
    end
  end

  #verificar que el address sea valido
  def addressValidate
    if address.present? && !address.match(/^[a-zA-Z0-9\s,'-]*$/)
      errors.add(:address, "must contain only letters, numbers and spaces")
    end
  end
end
