module CrudController
  extend ActiveSupport::Concern

  module ClassMethods

    # 使い方
    # crud_controller User, [:index, :show, :create, :update, :destroy]
    #
    def crud_controller clazz, methods=[:index, :show, :new, :create, :update, :destroy]

      # 複数形と単数形の名前をよく使うから作っておく
      table_name = clazz.to_s.tableize.gsub("/","_").to_sym
      model_name = clazz.to_s.underscore.gsub("/","_").to_sym

      # パンクズの追加
      path_postfix = (table_name == model_name) ? "_index" : ""
      add_breadcrumb clazz.model_name.human + I18n.t("crud.index"), {action: :index}

      # helper等で利用
      self.before_action { @subject = clazz }

      # before_action
      define_scope(clazz)
      define_find_all(clazz,table_name,model_name)            if methods.include?(:index)
      define_find_one(clazz,table_name,model_name,methods)    if ([:show,:edit,:update,:destroy]-methods).length < 4
      define_save_filter(clazz,table_name,model_name,methods) if ([:create,:update]-methods).length < 2
      define_new_one(clazz,table_name,model_name,methods)     if ([:new,:create]-methods).length < 2

      # permit_params
      define_one_params(clazz,table_name,model_name)          if ([:new,:create,:show,:edit,:update,:destroy]-methods).length < 6

      # action
      define_index(clazz,table_name,model_name)               if methods.include?(:index)
      define_show(clazz,table_name,model_name)                if methods.include?(:show)
      define_new(clazz,table_name,model_name)                 if methods.include?(:new)
      define_edit(clazz,table_name,model_name)                if methods.include?(:edit)
      define_create(clazz,table_name,model_name)              if methods.include?(:create)
      define_update(clazz,table_name,model_name)              if methods.include?(:update)
      define_destroy(clazz,table_name,model_name)             if methods.include?(:destroy)
      define_delete_all(clazz,table_name,model_name)          if methods.include?(:delete_all)
    end

  private
    def define_scope(clazz)
      define_method :scope do
        clazz
      end
    end

    # find_allの定義
    def define_find_all(clazz,table_name,model_name)
      self.before_action :find_all, only: [:index]
      define_method :find_all do
        @page         = (params[:page]||1).to_i
        @per_page     = (params[:pp]||30).to_i
        params[:s]  ||= "id desc"

        # 下記のようなことをしている
        # @users = User.search(params).result.page(@page).find_all(params).per(@per_page)
        #
        # serarch.result: ransack ( https://github.com/activerecord-hackery/ransack )
        # page.per      : kaminari ( https://github.com/amatsuda/kaminari )
        @per_page     = @per_page.to_i
        @q            = scope.search(params[:q])
        Rails.logger.debug "----------------------"
        Rails.logger.debug params[:q].inspect
        Rails.logger.debug @q.result.to_sql
        Rails.logger.debug "----------------------"

        @resources = instance_variable_set "@#{table_name}", @q.
          result.
          find_all(params).
          page(@page).
          per(@per_page)
      end
    end

    # find_oneの定義
    def define_find_one(clazz,table_name,model_name,methods)
      self.before_action :find_one, only: methods.select{|m| [:show,:edit,:update,:destroy].include?(m)}
      define_method :find_one do
        @resource = instance_variable_set "@#{model_name}", scope.find(params[:id])
      end
    end

    # save_filterの定義
    def define_save_filter(clazz,table_name,model_name,methods)
      self.before_action :save_filter, only: methods.select{|m| [:create,:update].include?(m)}
      define_method :save_filter do
        yield if block_given?
      end
    end

    # new_oneの定義
    def define_new_one(clazz,table_name,model_name,methods)
      self.before_action :new_one, only: methods.select{|m| [:new,:create].include?(m)}
      define_method :new_one do
        @resource = instance_variable_set "@#{model_name}", scope.new(one_params)
      end
    end

    # one_paramsの定義
    def define_one_params(clazz,table_name,model_name)
      define_method :one_params do
        params.fetch(model_name,{}).permit(*clazz.attribute_names)
      end
    end

    # indexの定義
    def define_index(clazz,table_name,model_name)
      define_method :index do
        yield if block_given?
        #render layout: "admins/layouts/index"
      end
    end

    # showの定義
    def define_show(clazz,table_name,model_name)
      define_method :show do
        add_breadcrumb clazz.model_name.human+t("crud.show"), {action: :show}
        yield if block_given?
      end
    end

    # newの定義
    def define_new(clazz,table_name,model_name)
      define_method :new do
        add_breadcrumb clazz.model_name.human+t("crud.new"), {action: :new}
        yield if block_given?
      end
    end

    # editの定義
    def define_edit(clazz,table_name,model_name)
      define_method :edit do
        add_breadcrumb clazz.model_name.human+t("crud.edit"), {action: :edit}
        yield if block_given?
      end
    end

    # createの定義
    def define_create(clazz,table_name,model_name)
      define_method :create do
        add_breadcrumb clazz.model_name.human+t("crud.new"), {action: :new}
        yield if block_given?
        if instance_variable_get("@#{model_name}").save
          flash[:notify_success] = "作成しました"
          redirect_to @create_redirect_path || self.class.instance_variable_get(:@_create_redirect_path) || {action: :index}
        else
          instance_variable_get("@#{model_name}").errors.tapp
          flash[:notify_error] = "作成できませんでした"
          render self.class.instance_variable_get(:@_create_error_action) || :new
        end
      end
    end

    def define_update(clazz,table_name,model_name)
      define_method :update do
        add_breadcrumb clazz.model_name.human+t("crud.edit"), {action: :edit}
        yield if block_given?
        if instance_variable_get("@#{model_name}").update_attributes one_params
          flash[:notify_success] = "更新しました"
          redirect_to @update_redirect_path || self.class.instance_variable_get(:@_update_redirect_path) || {action: :index}
        else
          instance_variable_get("@#{model_name}").errors.tapp
          flash[:notify_error] = "更新できませんでした"
          render self.class.instance_variable_get(:@_update_error_action) || :edit
        end
      end

    end

    def define_destroy(clazz,table_name,model_name)
      define_method :destroy do
        flash[:notify_success] = "削除しました"
        yield if block_given?
        instance_variable_get("@#{model_name}").destroy
        redirect_to @destroy_redirect_path || self.class.instance_variable_get(:@_destroy_redirect_path) || {action: :index}
      end
    end

    def define_delete_all(clazz,table_name,model_name)
      define_method :delete_all do
        yield if block_given?
        clazz.where(id: params[:ids].split(",")).destroy_all
        redirect_to self.class.instance_variable_get(:@_destroy_redirect_path) || {action: :index}
      end
    end

    # redirect_path, error_actionの一括定義
    %w(create update destroy).each do |action|
      define_method "#{action}" do |opts|
        %w(redirect_path error_action).each do |path|
          instance_variable_set("@_#{action}_#{path}",opts[path.to_sym])
        end
      end
    end

  end
end
