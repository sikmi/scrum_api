class Api::V1::Projects::TicketsController < Api::V1::Projects::ApplicationController
  resource_description do
    name 'チケット'
    short ''
    api_base_url '/api/v1/projects/:project_id'
    APP_ERRORS.pick(401, 412, 426, 403).each{ |opts| error(opts) }
  end

  api :GET, '/tickets', 'プロジェクト一覧'
  def index
  end

  api :GET, '/tickets/:id'
  def show
  end

  api :POST, '/tickets'
  def create
  end

  api :PUT, '/tickets/:id'
  def update
  end

  api :DELETE, '/tickets/:id'
  def destroy
  end
end
