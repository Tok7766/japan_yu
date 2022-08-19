class Favorite < ApplicationRecord
  belongs_to :customer
  belongs_to :post_image
  validates_uniqueness_of :post_image_id, scope: :customer_id
end
