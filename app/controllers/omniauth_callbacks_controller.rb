class OmniauthCallbacksController < ApplicationController
  include Devise::Controllers::Rememberable

  def all
    auth = request.env["omniauth.auth"]

    # user が存在するか
    exists_flg = User.exists?( provider: auth.provider, uid: auth.uid )

    # profiderとuidでuserレコードを検索。存在しなければ、新たに作成する
    user = User.from_omniauth(auth)

    # userレコードが既に保存されているか
    # TODO redirect 先を変更すること
    if user.persisted?
      remember_me(user)
      if exists_flg
        # ログインに成功
        flash[:notice_success] = "ログインに成功しました"
        sign_in user
        redirect_to root_path
      else
        # 登録に成功
        flash[:notice_success] = "登録に成功しました"
        sign_in user
        redirect_to root_path
      end
    else
      # ログインに失敗し、サインイン画面に遷移
      flash[:notice_error] = "ログインに失敗しました"
      session["devise.user_attributes"] = user.attributes
      redirect_to root_path
    end
  end

  # alias_methodはクラスやモジュールのメソッドに別名をつけます
  # 実態がallメソッドのtwitterメソッドを定義しています
  # こうすることで、様々なメソッド名で同じ処理を実装することができます。
  # OAuthの処理はほとんど同じためこのようにしています。
  # 例えば、Facebookに対応する場合、alias_method :facebook, :allだけですみます
  alias_method :github, :all
end
