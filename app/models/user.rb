class User < ApplicationRecord
    validates :email, presence: true, unique: true
end