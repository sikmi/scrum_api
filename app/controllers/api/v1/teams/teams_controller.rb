class Api::V1::Teams::TeamsController < Api::V1::Teams::ApplicationController

  resource_description do
    name 'チーム'
    short 'チーム単位で決済する予定'
    api_base_url '/api/v1'
    APP_ERRORS.pick(401, 412, 426, 403).each{ |opts| error(opts) }
  end

  api :GET, '/teams', '利用可能なチーム一覧の取得'
  def index
  end

  api :GET, '/teams/:id', 'チーム情報の取得'
  def show
  end

  api :POST, '/teams', 'チームの新規作成'
  def create
  end

  api :PUT, '/teams/:id', 'チーム情報の更新'
  def update
  end

  api :DELETE, '/teams/:id', 'チームの削除'
  def destroy
  end

end
