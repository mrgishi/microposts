class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :micropost
  validates :content, presence: true, length: { maximum: 255 }
  def feed_comments
    Comment.where(user_id: self.following_ids + [self.id])
  end
end
