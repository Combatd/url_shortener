class ShortenedUrl < ApplicationRecord
    validates :submit_user_id, presence: true
    validates :short_url, uniqueness: true
    validates :short_url, presence: true
    validates :long_url, presence: true
    validate :no_spamming, :nonpremium_max

    belongs_to(:submitter,
        primary_key: :id,
        foreign_key: :submit_user_id,
        class_name: :User
    )

    has_many( :visits, dependent: :destroy,
        primary_key: :short_url,
        foreign_key: :shortened_url,
        class_name: :Visit
    )

    has_many(:visitors,
        Proc.new { distinct }, 
        through: :visits,
        source: :user
    )    

    has_many :tag_topics, 
        through: :taggings, 
        source: :tag_topic

    def self.random_code
        new_url = SecureRandom.urlsafe_base64

        until !ShortenedUrl.exists?(short_url: new_url)
            new_url = SecureRandom.urlsafe_base64
        end

        return new_url
    end

    def self.generate_short_url(user, long_url)
        short_url = ShortenedUrl.create! submit_user_id: user.id, 
           long_url: long_url, 
           short_url: self.random_code
    end

    def num_clicks
        self.visits.count
    end

    def num_uniques
        self.visitors.count
    end

    def num_recent_uniques
        Visit.distinct.where(
            shortened_url_id: self.id,
            created_at: 10.minutes.ago..Time.now
        ).count(:user_id)
    end

    def no_spamming
        submissions = submitter.shortened_urls.where(
            created_at: 1.minute.ago..Time.now
        ).count

        if submissions >= 5
            errors[:base] << "No more than 5 URLs per minute allowed"
        end
    end

    def nonpremium_max
        return if User.find(self.submit_user_id).premium

        if submitter.shortened_urls.count >= 5
            errors[:user] << "is not premium and has a 5 URL limit"
        end
    end

    # ShortenedUrl.prune(minutes)
    def self.prune(minutes)
        visited = ShortenedUrl.where( updated_at < minutes.minutes.ago && created_at > 30.minutes.ago )

        return visited.destroy!
    end

end