class Group < ApplicationRecord
  has_many :boards
  has_many :user_groups
  accepts_nested_attributes_for :user_groups, allow_destroy: true
  has_many :users, through: :user_groups

  validates :name, presence:{message: 'は,必須項目です.'}, length: { maximum: 20 }
end
