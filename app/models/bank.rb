class Bank < ApplicationRecord
    #validar que name, address y phone no puedan ser nulos
    validates :name, :address, :phone, presence: true, length: { maximum: 255 }

end
