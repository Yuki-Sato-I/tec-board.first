class Board < ApplicationRecord
  belongs_to :groups, optional: true
  validates :content, presence: true
  validates :title ,presence: true
end
