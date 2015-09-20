# API用の大元Controller
class Api::ApplicationController < ApplicationController
  protect_from_forgery with: :null_session
  respond_to :json

  include Api::Concerns::ErrorRescue
  include Api::Concerns::Rendering


  class AppErrors

    def initialize
      @errors = [
        { code: 401, desc: 'Unauthorized: Basic認証エラー（開発環境のみ）' },
        { code: 412, desc: 'Precondition Failed: コンシューマートークンが不正な場合' },
        { code: 426, desc: 'Upgrade Required: アップグレード要求' },
        { code: 403, desc: 'Forbidden: アクセストークン認証エラー' },
        { code: 404, desc: 'Not Found: リソースが見つからない' },
        { code: 422, desc: 'Unprocessable Entity: バリデーションエラー' },
        { code: 400, desc: 'Bad Request: 想定はしているが、クライアント側ではどうしようもないエラー' }
      ]
    end

    def all
      @errors
    end

    def pick(*codes)
      @errors.select{|er| codes.include? er[:code] }
    end

  end

  APP_ERRORS = AppErrors.new

end
