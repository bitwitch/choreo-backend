class Choreography < ApplicationRecord
  belongs_to :user
  has_many :poses
  has_many :likes 
  has_many :comments 
end
