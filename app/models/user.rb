class User < ApplicationRecord
  
  mount_uploader :avatar, PhotoUploader
  has_merit

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  #after_save :create_trip_gostation_record, on: :create

  has_many :checkins, dependent: :destroy
  has_many :checkedin_gostations, through: :checkins, source: :gostation

  has_many :challenges, dependent: :destroy
  has_many :challenged_trips, through: :challenges, source: :trip

  has_many :trip_gostations

  has_many :followships, dependent: :destroy
  has_many :followings, through: :followships

  has_many :comments, dependent: :destroy
  has_many :commented_trips, through: :comments, source: :trip

  has_many :user_products
  has_many :products, through: :user_products, source: :product

  def admin?
    self.role == "admin"
  end
   
  def following?(user)
    self.followings.include?(user)
  end
  
  def check_avatar(user)
    if user.avatar.nil?
      "avatar.png"
    else
      user.avatar
    end
  end

  def getUserLevel(exp)
    if exp > 100000
      return 9
    elsif exp > 50000
      return 8
    elsif exp > 30000
      return 7
    elsif exp > 10000
      return 6
    elsif exp > 6000
      return 5
    elsif exp > 3000
      return 4
    elsif exp > 1000
      return 3
    elsif exp > 500
      return 2
    else
      return 1
    end
  end
  
end
