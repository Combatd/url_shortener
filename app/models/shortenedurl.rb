class ShortenedUrl < ApplicationRecord
    validates :short_url, uniqueness: true
    validates :short_url, presence: true
    validates :long_url, uniqueness: true
    validates :long_url, presence: true
end