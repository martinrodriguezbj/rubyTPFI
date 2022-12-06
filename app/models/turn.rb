class Turn < ApplicationRecord
  belongs_to :bank
  belongs_to :user

  validates :day, :hour, :reason, presence: true

  def to_s
    "#{day} | #{hour} | #{reason}"
  end
end
