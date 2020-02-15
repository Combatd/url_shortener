class TagTopic < ApplicationRecord
    validates :tag_topic_id, :url_id, uniqueness: true
    validates :tag_topic_id, :url_id, presence: true


end