module User::Omniauth
  extend ActiveSupport::Concern

  module ClassMethods
    # provider, uid を持つ user を作成
    def from_omniauth(auth)

      hash = { provider: auth.provider, uid: auth.uid }

      user = User.find_or_initialize_by(hash)
      user.update( {
        name: auth.info.name,
        nickname: auth.info.nickname,
        email: auth.info.email,
        image: auth.info.image
      })
      user
    end

    # session 情報から user データを取得
    def new_with_session(params, session)
      if session["devise.user_attributes"]
        new(session["devise.user_attributes"], without_protection: true) do |user|
          user.attributes = params
          user.valid?
        end
      else
        super
      end
    end
  end

  # passwordの認証を行わない
  def password_required?
    super && provider.blank?
  end
  
  # メールアドレスの認証を行わない
  def email_required?
    super && provider.blank?
  end
end
