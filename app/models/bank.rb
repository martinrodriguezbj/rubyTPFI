class Bank < ApplicationRecord
    has_many :turns
    has_many :schedules
    belongs_to :locality
    #validar que name, address y phone no puedan ser nulos
    validates :name, :address, :phone, presence: true, length: { maximum: 255 }

end
