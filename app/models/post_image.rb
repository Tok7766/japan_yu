class PostImage < ApplicationRecord
  belongs_to :customer
  has_many :favorites, dependent: :destroy
  has_many :favorited_customers, through: :favorites, source: :customer
  has_one_attached :image

  def favorited_by?(customer)
    favorites.exists?(customer_id: customer.id)
  end
end
