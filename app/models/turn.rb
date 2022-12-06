class Turn < ApplicationRecord
  belongs_to :bank
  belongs_to :user

  validates :day, :hour, :reason, presence: true

  def to_s
    "Bank: #{bank.name} | Day: #{day} |Hour: #{hour} |Reason: #{reason} |State: #{state}"
  end
end
