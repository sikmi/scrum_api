class Api::V1::Teams::ProjectsController < Api::V1::Teams::ApplicationController

  resource_description do
    resource_id "team_projects"
    name 'チームで利用できるプロジェクト'
    short 'チームで利用しているプロジェクト'
    api_base_url '/api/v1/teams/:team_id'
    APP_ERRORS.pick(401, 412, 426, 403).each{ |opts| error(opts) }
  end

  api :GET, '/projects', 'プロジェクト一覧'
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
