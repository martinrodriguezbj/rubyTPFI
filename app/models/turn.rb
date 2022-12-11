class Turn < ApplicationRecord
  belongs_to :bank
  belongs_to :user

  validates :day, :hour, :reason, presence: true
  validate :day_past

  def to_s
    "Bank: #{bank.name} | Day: #{day} |Hour: #{hour} |Reason: #{reason} |State: #{state}"
  end

  def day_past
    if day < Date.today
      errors.add(:day, "can't be in the past")
    end
  end

end
