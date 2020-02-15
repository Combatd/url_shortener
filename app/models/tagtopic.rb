# Table name: tag_topics
#
#  id         :bigint           not null, primary key
#  topic      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null

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
   
    # TagTopic#popular_links that returns the 5 most visited links for that TagTopic along with the number of times each link has been clicked.

    def popular_links
        short_urls.joins(visits),
        group(id),
        order('COUNT(visitors.visitor_id),
            DESC'),
        select('short_url, COUNT(visitors.visitor_id) AS number_of_visits'),
        limit(5)
    end

end