class Bank < ApplicationRecord
    has_many :turns
    has_many :schedules
    belongs_to :locality
    #validar que name, address y phone no puedan ser nulos
    validates :name, :address, :phone, presence: true, length: { maximum: 255 }
    validate :nameValidate, :addressValidate, :phoneValidate

  #verificar que el name sean solo letras y espacios
    def nameValidate
        if name.present? && !name.match(/^[a-zA-Z\s]+$/)
            errors.add(:name, "must contain only letters and spaces")
        end
    end

  #verificar que el address sea valido
  def addressValidate
    if address.present? && !address.match(/^[a-zA-Z0-9\s,'-]*$/)
      errors.add(:address, "must contain only letters, numbers and spaces")
    end
  end

  #verificar que el telefono sea valido
    def phoneValidate
        if phone.present? && !phone.match(/^[0-9]+$/)
            errors.add(:phone, "must contain only numbers")
        end
    end

end
