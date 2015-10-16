module Crud
  extend ActiveSupport::Concern

  included do
    # 一覧用のscope
    scope :find_all, ->(params){}
  end

  module ClassMethods

    # TODO: CrudControllerと同様の事をしているため、どうにかしたい。
    # crud
    def records(params = {})
      params.reverse_merge!({
        page: 1,
        pp: 20,
        s: "id desc"
      })

      # for sort
      if params[:s].is_a?(String) and params[:s].present?
        params[:s] = params[:s].split(",")
      end

      search(params[:q]).
      result.
      page(params[:page]).
      find_all(params).
      per(params[:pp])
    end

    def all_records(params = {})
      params.reverse_merge!({
      })

      search(params[:q]).
      result.
      find_all(params)
    end


    # 詳細用のfind
    def find_one(params)
      find params[:id]
    end

  end

end

