# rescue_fromの記述
module Api::Concerns::ErrorRescue
  extend ActiveSupport::Concern

  included do
    if Rails.env.production?
      rescue_from Exception, with: :render_500
    end
    rescue_from ActionController::RoutingError, with: :render_404_url
    rescue_from ActiveRecord::RecordNotFound, with: :render_404_record
    #rescue_from Mysql2::Error, ActiveRecord::RecordNotUnique,  with: :render_422_uniq
    rescue_from ActiveRecord::RecordNotUnique, with: :render_422_uniq
  end

  # = Rubyのエラー
  def render_500(e=nil)
    Rails.logger.error e.class
    Rails.logger.error e.message
    Rails.logger.error e.backtrace
    render_error(500, [e.message] + e.backtrace)
  end

  # = URL NotFound
  def render_404_url(e=nil)
    Rails.logger.info e.message
    Rails.logger.info e.backtrace
    render_error(404, 'URLが見つかりません（URL Not Found）')
  end

  # = ID NotFound
  def render_404_record(e=nil)
    Rails.logger.info e.message
    Rails.logger.info e.backtrace
    render_error(404, 'リソースが見つかりません（Record Not Found）')
  end

  # = DB NotUniq
  def render_422_uniq(e=nil)
    Rails.logger.info e.message
    Rails.logger.info e.backtrace
    render_error(422, 'リソースはすでに登録されています（Record Not Unique）')
  end

end
