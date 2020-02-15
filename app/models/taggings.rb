class Tagging < ApplicationRecord
    validates :url_id, :tag_topic_id, presence: true
    
    belongs_to( :short_url,
    primary_key: :id,
    foreign_key: :url_id,
    class_name: :ShortenedUrl
    )
    
end