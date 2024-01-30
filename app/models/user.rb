class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[google_oauth2]

  has_many :posts, dependent: :destroy

  def self.from_omniauth(auth)
    user = User.find_by(email: auth.info.email)

    if user
      user.update(provider: auth.provider, uid: auth.uid)
    else
      user = User.create(
        email: auth.info.email,
        name: auth.info.name,
        provider: auth.provider,
        uid: auth.uid,
        password: Devise.friendly_token[0,20]
      )
    end

    user
  end
end
