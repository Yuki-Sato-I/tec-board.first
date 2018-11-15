class User < ApplicationRecord
  before_save {self.email = email.downcase}
  validates :name,  presence: {message: 'は,必須項目です.'}, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: { message: 'は,必須項目です.'}, length: { maximum: 255 },format: { with: VALID_EMAIL_REGEX ,message:'は,有効なものを入れてください.' },uniqueness: { case_sensitive: false }
                                                                     #有効なメールアドレス確認                     #大文字小文字を区別しない
  has_secure_password
  validates :password, presence: {message: 'は,必須項目です.'}, length: { minimum: 6 ,message: 'は,最低でも６文字です.'}
end
