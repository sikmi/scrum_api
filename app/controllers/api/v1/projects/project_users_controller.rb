class Api::V1::Projects::ProjectUsersController < Api::V1::Projects::ApplicationController

  resource_description do
    name 'プロジェクトメンバー'
    short ''
    api_base_url '/api/v1/projects/:project_id'
    APP_ERRORS.pick(401, 412, 426, 403).each{ |opts| error(opts) }
  end

  api :GET, '/project_users', 'プロジェクト一覧'
  def index
  end

  api :GET, '/project_users/:id'
  def show
  end

  api :POST, '/project_users'
  def create
  end

  api :PUT, '/project_users/:id'
  def update
  end

  api :DELETE, '/project_users/:id'
  def destroy
  end

end
