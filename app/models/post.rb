class Post < ApplicationRecord
  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags

  validates :body, presence: true
  validates :image, presence: true

  mount_uploader :image, ImageUploader
end
