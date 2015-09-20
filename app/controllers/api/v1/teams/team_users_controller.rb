class Api::V1::Teams::TeamUsersController < Api::V1::Teams::ApplicationController
  resource_description do
    name 'チーム内メンバー'
    short 'チーム内のメンバー'
    api_base_url '/api/v1/temas/:team_id'
    APP_ERRORS.pick(401, 412, 426, 403).each{ |opts| error(opts) }
  end

  api :GET, '/team_users', 'チーム内ユーザー一覧'
  def index
  end

  api :GET, '/team_users/:id', 'ユーザー詳細'
  def show
  end

  api :POST, '/team_users'
  def create
  end

  api :PUT, '/team_users/:id'
  def update
  end

  api :DELETE, '/team_users/:id'
  def destroy
  end

end
