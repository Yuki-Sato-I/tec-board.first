class Group < ApplicationRecord
  has_many :boards
  has_many :user_groups
  has_many :albums
  has_many :chats
  accepts_nested_attributes_for :user_groups, allow_destroy: true
  has_many :users, through: :user_groups

  validates :name, presence: true, length: { maximum: 20 }
end
 