class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable, :recoverable

  devise :database_authenticatable, :registerable, :validatable, :rememberable,
    :omniauthable, omniauth_providers: [:google_oauth2, :facebook, :twitter]

  has_many :lessons, dependent: :destroy
  has_many :activities, dependent: :destroy
  has_many :active_relationships, class_name: Relationship.name,
    foreign_key: "follower_id", dependent: :destroy
  has_many :passive_relationships, class_name: Relationship.name,
    foreign_key: "followed_id", dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower

  def current_user? user
    self == user
  end

  def follow other_user
    active_relationships.create followed_id: other_user.id
  end

  def unfollow other_user
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  def following? other_user
    following.include? other_user
  end

  class << self
    def from_omniauth auth
      find_or_create_by(provider: auth.provider, uid: auth.uid) do |user|
        user.email = auth.info.email.present? ?
          auth.info.email :
          "#{Devise.friendly_token[0,20]}#{Time.now.strftime("%Y%m%dT%H%M%S%z")
          }@default.mail"
        user.password = Settings.default_password
        user.name = auth.info.name
        user.avatar = auth.info.image.gsub "http://", "https://"
      end
    end

    def new_with_session params, session
      super.tap do |user|
        if data = session["devise.#{session["provider"]}_data"] &&
          session["devise.#{session["provider"]}_data"]["extra"]["raw_info"]
          user.email = data["email"] if user.email.blank?
        end
      end
    end
  end
end
