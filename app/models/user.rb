class User < ApplicationRecord
    validates :username, :password, presence: true, length: { maximum: 255 }
end
