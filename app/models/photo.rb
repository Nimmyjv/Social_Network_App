class Photo < ApplicationRecord
  belongs_to :user

  default_scope -> { includes(:likes).order('created_at DESC') }

  mount_uploader :avatar, AvatarUploader

  validates_presence_of :user

  has_many :likes
  has_many :comments
end
