module CheckRole
  extend ActiveSupport::Concern

  def check_current_user
    if !current_user.present?
      flash[:notify_error] = "ログインしていないため、アクセスできません。"
      redirect_to @check_current_user_redirect_path || root_path
    end
  end

end

