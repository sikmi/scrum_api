class Api::V1::Teams::PlansController < Api::V1::Teams::ApplicationController
  resource_description do
    name 'プラン'
    short 'チーム単位で決済する予定'
    api_base_url '/api/v1/teams/:team_id'
    APP_ERRORS.pick(401, 412, 426, 403).each{ |opts| error(opts) }
  end

  api :PUT, '/plan', 'プランの変更'
  def update
  end
end
