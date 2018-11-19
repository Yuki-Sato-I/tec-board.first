class User < ApplicationRecord
  has_many :user_groups    #順番大事！！！！
  has_many :groups, through: :user_groups


  
  attr_accessor :remember_token
  before_save {self.email = email.downcase}
  validates :name,  presence: {message: 'は,必須項目です.'}, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: { message: 'は,必須項目です.'}, length: { maximum: 255 },format: { with: VALID_EMAIL_REGEX ,message:'は,有効なものを入れてください.' },uniqueness: { case_sensitive: false,message:'は,登録されていないものを入力してください.' }
                                                                     #有効なメールアドレス確認                     #大文字小文字を区別しない
  has_secure_password
  validates :password, presence: {message: 'は,必須項目です.'}, length: { minimum: 6 ,message: 'は,最低でも６文字です.'}
  # 渡された文字列のハッシュ値を返す
  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                              BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # ランダムなトークンを返す
  def self.new_token
    SecureRandom.urlsafe_base64
  end

  # 永続セッションのためにユーザーをデータベースに記憶する
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end
  # 渡されたトークンがダイジェストと一致したらtrueを返す
  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end
  # ユーザーのログイン情報を破棄する
  def forget
    update_attribute(:remember_digest, nil)
  end
end
