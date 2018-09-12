class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :lockable, :timeoutable

         has_many :videoposts, dependent: :destroy

         has_many :active_relationships, class_name:  "Relationship",
                                         foreign_key: "follower_id",
                                         dependent:   :destroy

         has_many :passive_relationships, class_name:  "Relationship",
                                          foreign_key: "followed_id",
                                          dependent:   :destroy

         has_many :following, through: :active_relationships, source: :followed
         has_many :followers, through: :passive_relationships, source: :follower

  validates :name,  presence: true, length: { maximum:  50 }

  def feed
    following_ids = "SELECT followed_id FROM relationships
                     WHERE follower_id = :user_id"
    Videopost.where("user_id IN (#{following_ids})
                     OR user_id = :user_id", user_id: id)
  end

  # ユーザーをフォローする
  def follow(other_user)
    following << other_user
  end

  # ユーザーをフォロー解除する
  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  # 現在のユーザーがフォローしてたらtrueを返す
  def following?(other_user)
    following.include?(other_user)
  end

end
