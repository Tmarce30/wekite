class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_attachments :photos

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  devise :omniauthable, omniauth_providers: [:facebook]

  has_many :favorites
  has_many :reviews
  has_many :spots
  has_many :pictures

  ratyrate_rater

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, uniqueness: true, presence: true
  validates :avatar, presence: true

  has_attachment  :avatar, accept: [:jpg, :png, :gif]

  def self.find_for_facebook_oauth(auth)
    user_params = auth.slice(:provider, :uid)
    user_params.merge! auth.info.slice(:email, :first_name, :last_name)
    user_params[:facebook_picture_url] = auth.info.image
    user_params[:token] = auth.credentials.token
    user_params[:token_expiry] = Time.at(auth.credentials.expires_at)
    user_params = user_params.to_h

    user = User.find_by(provider: auth.provider, uid: auth.uid)
    user ||= User.find_by(email: auth.info.email) # User did a regular sign up in the past.
    if user
      user.update(user_params)
    else
      user = User.new(user_params)
      user.avatar_url = auth.info.image
      #user.age = (Date.today - Date.strptime(auth.extra.raw_info.birthday,'%m/%d/%Y')).to_i/365
      user.password = Devise.friendly_token[0,20]  # Fake password for validation
      user.save!
    end

    return user
  end
end

