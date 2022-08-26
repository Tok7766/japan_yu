class PostImage < ApplicationRecord
  belongs_to :customer
  has_many :favorites, dependent: :destroy
  has_many :favorited_customers, through: :favorites, source: :customer
  has_many :post_image_comments, dependent: :destroy
  has_one_attached :image
  
  validates :title, presence: true
  validates :body, presence: true,length:{maximum:200}

  def favorited_by?(customer)
    favorites.exists?(customer_id: customer.id)
  end
  
  # 検索方法分岐
  def self.looks(search, word)
    if search == "perfect_match"
      @post_image = PostImage.where("title LIKE?","#{word}")
    elsif search == "forward_match"
      @post_image = PostImage.where("title LIKE?","#{word}%")
    elsif search == "backward_match"
      @post_image = PostImage.where("title LIKE?","%#{word}")
    elsif search == "partial_match"
      @post_image = PostImage.where("title LIKE?","%#{word}%")
    else
      @post_image = PostImage.all
    end
  end
end
