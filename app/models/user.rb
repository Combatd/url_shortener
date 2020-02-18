class User < ApplicationRecord
    validates :email, presence: true
    validates :email, uniqueness: true

    has_many( :submitted_urls,
        primary_key: :id,
        foreign_key: :submit_user_id,
        class_name: :Shortenedurl
    )

    has_many( :visits,
        primary_key: :id,
        foreign_key: :visitor_id,
        class_name: :Visit
    )

    has_many( :visited_urls,
        -> { distinct },
        through: :visits,
        source: :short_url
    )

end