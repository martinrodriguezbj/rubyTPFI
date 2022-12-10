class Locality < ApplicationRecord
    has_many :banks
    validates :locality, :province, presence: true, length: { maximum: 255 }
    validate :locality_and_pronvince_uniqueness

    protected
    def locality_and_pronvince_uniqueness
        if Locality.where(locality: locality, province: province).exists?
            errors.add(:locality, "and province combination already exists")
        end
    end
end
