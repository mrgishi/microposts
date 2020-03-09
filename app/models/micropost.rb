class Micropost < ApplicationRecord
  belongs_to :user
  validates :content, presence: true, length: { maximum: 255 }

  has_many :favorite_relationships, dependent: :destroy
  has_many :liked_by, through: :favorite_relationships, source: :user
end