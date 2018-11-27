class Contact < ApplicationRecord
  validates :questioner_name, presence: true
  validates :questioner_email, presence: true
  validates :content, presence: true
end
