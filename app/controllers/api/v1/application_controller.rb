class Api::V1::ApplicationController < Api::ApplicationController
  before_action :log_request
  after_action :log_response

  def log_request
    Rails.logger.info "CONSUMER=TOKEN :#{request.headers['X-CONSUMER-TOKEN']}"
    Rails.logger.info "ACCESS=TOKEN: #{request.headers['X-ACCESS-TOKEN']}"
  end

  def log_response
    Rails.logger.debug response.body
  end

end
