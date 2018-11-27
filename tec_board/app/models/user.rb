class User < ApplicationRecord
  has_many :user_groups    #順番大事！！！！
  has_many :groups, through: :user_groups
  has_many :chats
  mount_uploader :image_name, ImageUploader


  
  attr_accessor :remember_token, :activation_token, :reset_token
  before_create :create_activation_digest
  before_save :downcase_email
  validates :name,  presence: {message: 'は,必須項目です.'}, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: { message: 'は,必須項目です.'}, length: { maximum: 255 },format: { with: VALID_EMAIL_REGEX ,message:'は,有効なものを入れてください.' },uniqueness: { case_sensitive: false,message:'は,登録されていないものを入力してください.' }
                                                                     #有効なメールアドレス確認                     #大文字小文字を区別しない
  has_secure_password
  validates :password, presence: {message: 'は,必須項目です.'}, length: { minimum: 6 ,message: 'は,最低でも６文字です.'},allow_nil: true
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
  def authenticated?(attribute,token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end
  # ユーザーのログイン情報を破棄する
  def forget
    update_attribute(:remember_digest, nil)
  end
    
  # アカウントを有効にする
  def activate
    update_attribute(:activated, true)
    update_attribute(:activated_at, Time.zone.now)
  end
  
  # 有効化用のメールを送信する
  def send_activation_email
    UserMailer.account_activation(self).deliver_now
  end

  # パスワード再設定の属性を設定する
  def create_reset_digest
    self.reset_token = User.new_token
    update_attribute(:reset_digest,  User.digest(reset_token))
    update_attribute(:reset_sent_at, Time.zone.now)
  end

  # パスワード再設定のメールを送信する
  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end

  # パスワード再設定の期限が切れている場合はtrueを返す
  def password_reset_expired?
    reset_sent_at < 2.hours.ago
  end

  private
    def downcase_email
      self.email = email.downcase
    end

    def create_activation_digest
      self.activation_token = User.new_token
      self.activation_digest = User.digest(activation_token)
    end
end
