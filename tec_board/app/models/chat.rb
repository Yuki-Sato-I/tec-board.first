class Chat < ApplicationRecord
  belongs_to :groups, optional: true
  belongs_to :users, optional: true
  validates :content, presence: true
end
