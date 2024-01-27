class Post < ApplicationRecord
  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags

  validates :body, presence: true
  validates :image, presence: true

  mount_uploader :image, ImageUploader

  def self.ransackable_attributes(auth_object = nil)
    ["tags"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["tags"]
  end
end
