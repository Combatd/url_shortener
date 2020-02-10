class ShortenedUrl < ApplicationRecord
    validates :submit_user_id, presence: true
    validates :short_url, uniqueness: true
    validates :short_url, presence: true
    validates :long_url, uniqueness: true
    validates :long_url, presence: true

    belongs_to(:submitter,
        primary_key: :id,
        foreign_key: :submit_user_id,
        class_name: :User
    )

    has_many( :visits, dependent: :destroy,
        primary_key: :short_url,
        foreign_key: :shortened_urlm
        class_name: :Visit
    )


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

    def num_clicks
        self.visits.count
    end

    def num_uniques
        self.visitors.count
    end

end