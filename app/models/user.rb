class User < ApplicationRecord
  has_many :posts, dependent: :destroy
  has_many :relationships, foreign_key: 'follower_id', dependent: :destroy
  has_many :active_relationships, class_name: 'Relationship',
                                  foreign_key: 'follower_id',
                                  dependent: :destroy
  has_many :passive_relationships, class_name: 'Relationship',
                                   foreign_key: 'followed_id',
                                   dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower
  has_many :following, through: :active_relationships, source: :followed
  has_one_attached :avatar

  before_save { self.email = email.downcase }
  validates :name, presence: true, length: { maximum: 25 }

  VALID_EMAIL_REGEX = /\A([\w+\-]\.?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i.freeze
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }

  validates :password, presence: true, length: { minimum: 6 }

  has_secure_password

  def feed
    following_ids = "SELECT followed_id FROM relationships
                     WHERE follower_id = :user_id"
    Post.where("user_id IN (#{following_ids}) OR user_id = :user_id", user_id: id)
  end

  def follow(other_user)
    following << other_user unless self == other_user
  end

  def unfollow(other_user)
    following.delete(other_user)
  end

  def following?(other_user)
    following.include?(other_user)
  end
end
