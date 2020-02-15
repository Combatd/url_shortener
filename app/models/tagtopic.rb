class TagTopic < ApplicationRecord
    validates :topic, uniqueness: true
    validates :topic, presence: true

    has_many :short_urls, 
    through: :taggings, 
    source: :short_url

end