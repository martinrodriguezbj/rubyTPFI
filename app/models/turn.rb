class Turn < ApplicationRecord
  belongs_to :bank
  belongs_to :user

  validates :day, :hour, :reason, presence: true
  validate :day_past, :day_valid

  def to_s
    "Bank: #{bank.name} | Day: #{day} |Hour: #{hour} |Reason: #{reason} |State: #{state}"
  end

  def day_past
    if day.present? && day < Date.today
      errors.add(:day, "can't be in the past")
    end
  end

  def day_valid
    if day.present? && hour.present? && reason.present?
      @day_name = day.strftime("%A")
      @bank = Bank.find(bank_id)
      @schedule = @bank.schedules.where(day: @day_name)
      @hour = hour.to_s.gsub(":", "").to_i
      @startAttention = @schedule.where(day: @day_name).first.startAttention
      @endAttention = @schedule.where(day: @day_name).first.endAttention
      @startAttention = @startAttention.to_s.gsub(":", "").to_i
      @endAttention = @endAttention.to_s.gsub(":", "").to_i
      estaEntre = (@startAttention..@endAttention).include?(@hour)
      #chequear si el turno ya se encuentra ocupado, y si ese turno no es el actual
      ocupado = @bank.turns.where(day: day, hour: hour).exists? && @bank.turns.where(day: day, hour: hour).first.id != id
      if !estaEntre
        errors.add(:hour, "is not valid, the bank is not open at that time")
      elsif ocupado
        errors.add(:hour, "is not valid, the bank is already occupied at that time")
      end
    end
  end
end
