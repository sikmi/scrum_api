class Api::V1::Projects::ProjectsController < Api::V1::Projects::ApplicationController

  resource_description do
    name 'プロジェクト'
    short ''
    api_base_url '/api/v1'
    APP_ERRORS.pick(401, 412, 426, 403).each{ |opts| error(opts) }
  end

  api :GET, '/projects'
  def index
  end

  api :GET, '/projects/:id'
  def show
  end

  api :POST, '/projects'
  def create
  end

  api :PUT, '/projects/:id'
  def update
  end

  api :DELETE, '/projects/:id'
  def destroy
  end

end
