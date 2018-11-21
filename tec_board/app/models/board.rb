class Board < ApplicationRecord
  belongs_to :groups, optional: true
  validates :content, presence:{message: 'は,必須項目です.'}
  validates :title ,presence: {message: 'は,必須項目です'}
end
