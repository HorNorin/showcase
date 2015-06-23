class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :omniauthable
         
  mount_uploader :image, ImageUploader
  
  validates_presence_of :username, unless: :sign_in_with_omniauth?
  validates_presence_of :email, unless: :sign_in_with_omniauth?
  validates_format_of :email, with: /\A[^@\s]+@[\w\-_\.]+\.\w{2,4}\z/i, unless: :sign_in_with_omniauth?
  validates_presence_of :password, unless: :sign_in_with_omniauth?
  validates_confirmation_of :password, unless: :sign_in_with_omniauth?
  validates_presence_of :password_confirmation, unless: :sign_in_with_omniauth?
  
  def self.sign_up_with_omniauth(auth)
    return false unless auth
    
    user = User.where("uid = ? AND provider = ?", auth.uid, auth.provider)
               .first_or_initialize
    user.uid = auth.uid
    user.provider = auth.provider
    user.email = auth.info.email if auth.provider == "facebook"
    user.username = auth.info.name
    user.remote_image_url = auth.info.image.gsub("http", "https")
    user.skip_confirmation!
    
    user.save ? user : false
  end
  
  private
  
  def sign_in_with_omniauth?
    uid && provider && ["facebook", "twitter"].include?(provider)
  end
end
