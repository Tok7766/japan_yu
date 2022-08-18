class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  has_many :post_images
  has_one_attached :profile_image
  
  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :followings, through: :relationships, source: :followed
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :followers, through: :reverse_of_relationships, source: :follower  
  
  
  def get_profile_image
    (profile_image.attached?) ? profile_image : 'no_image.jpg'
  end
   #フォローした時の処理
  def follow(customer)
    relationships.create(followed_id: customer.id)
  end
  #フォローを外すときの処理
  def unfollow(customer)
    relationships.find_by(followed_id: customer.id).destroy
  end
  #フォローしているか判定
  def following?(customer)
    followings.include?(customer)
  end
end
