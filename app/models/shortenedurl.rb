class ShortenedUrl < ApplicationRecord
    validates :short_url, uniqueness: true
    validates :short_url, presence: true
    validates :long_url, uniqueness: true
    validates :long_url, presence: true



    def self.random_code
        new_url = SecureRandom.urlsafe_base64

        until !ShortenedUrl.exists?(short_url: new_url)
            new_url = SecureRandom.urlsafe_base64
        end

        return new_url
    end

    def self.generate_short_url(user, long_url)
        ShortenedUrl.create!(
           submit_user_id: user.id, 
           long_url: long_url, 
           short_url: ShortenedUrl.random_code
        )
    end

end