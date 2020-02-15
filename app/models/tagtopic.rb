class TagTopic < ApplicationRecord
    validates :topic, uniqueness: true
    validates :topic, presence: true

    has_many(:taggings, 
    primary_key: :id, 
    foreign_key: :tag_topic_id, 
    class_name: :Tagging
    )

    has_many(:short_urls, 
    through: :taggings, 
    source: :short_url
    )
    
end