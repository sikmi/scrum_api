class Api::V1::Projects::IssuesController < Api::V1::Projects::ApplicationController
  resource_description do
    name 'バグ'
    short ''
    api_base_url '/api/v1/projects/:project_id'
    APP_ERRORS.pick(401, 412, 426, 403).each{ |opts| error(opts) }
  end

  api :GET, '/issues', 'プロジェクト一覧'
  def index
  end

  api :GET, '/issues/:id'
  def show
  end

  api :POST, '/issues'
  def create
  end

  api :PUT, '/issues/:id'
  def update
  end

  api :DELETE, '/issues/:id'
  def destroy
  end
end
