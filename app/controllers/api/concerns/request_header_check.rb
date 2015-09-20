# X-CONSUMERなどの前提になる条件のbefore_action
module Api::Concerns::RequestHeaderCheck
  extend ActiveSupport::Concern

  included do
    before_action :newrelic_pinger_check
    before_action :valid_consumer_token?
    before_action :pending_consumer_token?
    before_action :closed_consumer_token?
    before_action :set_current
  end

  # クラスメソッド
  module ClassMethods
    def login_required(opts={})
      before_action :valid_access_token?, opts
    end
  end

  # newrelic pinger
  def newrelic_pinger_check
    if params[:pinger_token] == "c0416c35952b499b91fc3e7fb9cae0be"
      request.headers['X-CONSUMER-TOKEN'] = Consumer.open.first.token
      request.headers['X-ACCESS-TOKEN'] = Device.first.access_token
    end
  end

  def set_current
    current_user
  end

  def current_consumer_state
    @consumer_state = Consumer.find_and_cache(request.headers['X-CONSUMER-TOKEN'])
  end

  def current_device
    Device.current = Device.find_and_cache(request.headers['X-ACCESS-TOKEN'])
  end

  def current_user
    User.current = User.find_and_cache(current_device.try(:user_id))
  end

  # = ConsumerTokenの有効性を確認する
  # - 412: 固定値）正規のアプリからしかアクセスできません（Invalid Consumer Token）
  def valid_consumer_token?
    render_error 412, '正規のアプリからしかアクセスできません（Invalid Consumer Token）' if current_consumer_state.nil?
  end

  # = ConsumerTokenが未公開か確認する
  # 423: 固定値）まだ公開前のアプリです（Update Required）
  def pending_consumer_token?
    render_error 423, 'まだ公開前のアプリです（Locked）' if current_consumer_state == 'pending'
  end

  # = ConsumerTokenの有効期限を確認する
  # - 426: 固定値）最新版のアプリをダウンロードしてください（Update Required）
  def closed_consumer_token?
    render_error 426, '最新版のアプリをダウンロードしてください（Update Required）' if current_consumer_state == 'closed'
  end

  # = AccessTokenの有効性を確認する
  # - 403: 固定値）正規のアプリからしかアクセスできません（Invalid Access Token）
  def valid_access_token?
    render_error 403, '正規のアプリからしかアクセスできません（Invalid Access Token）' if current_user.blank?
  end
end
