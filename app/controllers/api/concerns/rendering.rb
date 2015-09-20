# render_errorなど共通で利用するメソッドを定義
module Api::Concerns::Rendering
  extend ActiveSupport::Concern

  included do
    before_action :index_paginator, only: [:index]
  end

  # = エラーのレンダリング
  def render_error(status, error_or_errors)
    return render status: status, json: {errors: [error_or_errors].flatten}
  end

  # = indexの処理
  def index_paginator
    @offset = params[:offset] || 0
    @limit = params[:limit] || 100
  end

  # = render_index
  def render_index(q, opts={})
    render json: {total: q.page.total_count, offset: @offset, limit: @limit, data: q.limit(@limit).offset(@offset).as_json(opts)}
  end

end
