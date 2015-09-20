class Api::V1::AccountsController < Api::V1::ApplicationController

  resource_description do
    name '会員'
    short '会員登録・情報取得・退会などログインするアカウントの管理'
    api_base_url '/api/v1'
    APP_ERRORS.pick(401, 412, 426).each{ |opts| error(opts) }
  end

  api :POST, '/account', '会員登録'
  APP_ERRORS.pick(422).each{ |opts| error(opts) }
  param :name, String, require: true
  param :email, String, require: true
  example <<-EOS
    code: 201
    {
      name: '太郎',
      email: 'taro@example.com'
    }
  EOS
  def create
  end


  api :GET, '/account', '会員情報取得'
  APP_ERRORS.pick(403, 404).each{ |opts| error(opts) }
  def show
    render json: { hello: 'world' }
  end

  api :PUT, '/account', '会員情報更新'
  APP_ERRORS.pick(403, 404, 422).each{ |opts| error(opts) }
  def update
  end

  api :DELETE, '/account', '会員退会'
  APP_ERRORS.pick(403, 404, 400).each{ |opts| error(opts) }
  def destroy
  end

end
