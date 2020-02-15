class Tagging < ApplicationRecord
    validates :url_id, :tag_topic_id, presence: true
    
end