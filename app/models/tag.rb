class Tag < ApplicationRecord
  has_many :post_tags
  has_many :posts, through: :post_tags

  def self.ransackable_attributes(auth_object = nil)
    ["name"]
  end
end
