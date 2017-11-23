class User < ApplicationRecord
  has_secure_password 
  validates :password, confirmation: true
  validates :username, uniqueness: true 

  has_many :friendships
  has_many :friends, class_name: 'User', through: :friendships, foreign_key: :friend_id
  has_many :choreographies
  has_many :likes 
  has_many :comments  
end
