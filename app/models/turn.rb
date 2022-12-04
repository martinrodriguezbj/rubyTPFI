class Turn < ApplicationRecord
  belongs_to :bank
  belongs_to :user

  validates :day, :hour, :reason, presence: true
end
