class Album < ApplicationRecord
  mount_uploaders :images, ImageUploader
  belongs_to :groups ,optional: true
  validates :title, presence: true
  validates :content, presence: true
  validates :images , presence: true
end
