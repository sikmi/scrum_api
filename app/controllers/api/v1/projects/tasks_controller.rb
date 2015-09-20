class Api::V1::Projects::TasksController < Api::V1::Projects::ApplicationController
  resource_description do
    name 'タスク'
    short ''
    api_base_url '/api/v1/projects/:project_id'
    APP_ERRORS.pick(401, 412, 426, 403).each{ |opts| error(opts) }
  end

  api :GET, '/tasks', 'プロジェクト一覧'
  def index
  end

  api :GET, '/tasks/:id'
  def show
  end

  api :POST, '/tasks'
  def create
  end

  api :PUT, '/tasks/:id'
  def update
  end

  api :DELETE, '/tasks/:id'
  def destroy
  end
end
