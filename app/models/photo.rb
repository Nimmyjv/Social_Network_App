class Photo < ApplicationRecord
  belongs_to :user
  acts_as_votable

  default_scope -> { order('created_at DESC') }

  mount_uploader :avatar, AvatarUploader

  validates_presence_of :user
end
