class Visit < ApplicationRecord
    validates :shortened_url, :visitor_id, presence: true

    belongs_to( :user,
        primary_key: :id,
        foreign_key: :visitor_id,
        class_name: :User
    )

    belongs_to( :short_url,
        primary_key: :short_url,
        foreign_key: :shortened_url,
        class_name: :Shortenedurl
    )

    # Factory method instantiates Visit object from a User to given Shortenedurl
    def self.record_visit!(user, shortened_url)
        Visit.create! (
            shortened_url: shortened_url.short_url, 
            visitor_id: user.id
        )
    end

end