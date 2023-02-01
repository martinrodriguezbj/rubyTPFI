class Locality < ApplicationRecord
    has_many :banks
    validates :locality, :province, presence: true, length: { maximum: 255 }
    validate :locality_and_pronvince_uniqueness, :localityValidate, :provinceValidate

    protected
    #la combinacion entre localidad y provincia debe ser unica
    def locality_and_pronvince_uniqueness
        if Locality.where(locality: locality, province: province).exists? && Locality.where(locality: locality, province: province).first.id != id
            errors.add(:locality, "and province combination already exists")
        end
    end

    #locality solo puede contener letras, espacios y numeros
    def localityValidate
        if locality.present? && !locality.match(/^[a-zA-Z0-9\s]+$/)
            errors.add(:locality, "must contain only letters, numbers and spaces")
        end
    end

    #province solo puede contener letras y espacios
    def provinceValidate
        if province.present? && !province.match(/^[a-zA-Z\s]+$/)
            errors.add(:province, "must contain only letters and spaces")
        end
    end

end
