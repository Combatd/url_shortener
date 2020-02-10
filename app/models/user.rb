class User < ApplicationRecord
    validates :email, presence: true
    validates :email, uniqueness: true

    has_many( :submitted_urls,
        primary_key: :id,
        foreign_key: :submit_user_id,
        class_name: :Shortenedurl
    )

end