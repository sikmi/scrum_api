module Api1Routes
  def api1_routes
    resource :account, only: [:show, :create, :update, :destroy]
    # チーム一覧
    resources :teams, only: [:index, :show, :create, :update, :destroy], module: 'teams' do
      # チームプランの変更
      resources :plan, only: [:update]
      # チーム参加
      resources :team_users, only: [:index, :show, :create, :update, :destroy]
      # プロジェクト
      resources :projects, only: [:index, :create, :update, :destroy]
    end
    # プロジェクト
    resources :projects, only: [:index, :show, :create, :update, :destroy], module: 'projects' do
      # プロジェクト参加
      resources :project_users, only: [:index, :show, :create, :update, :destroy]
      # プロダクトバックログ
      resources :tickets, only: [:index, :show, :create, :update, :destroy] do
        resources :comments, only: [:index, :create, :update, :destroy]
      end
      # スプリントバックログ
      resources :tasks, only: [:index, :show, :create, :update, :destroy] do
        resources :comments, only: [:index, :create, :update, :destroy]
      end
      # バグバックログ
      resources :issues, only: [:index, :show, :create, :update, :destroy] do
        resources :comments, only: [:index, :create, :update, :destroy]
      end
    end
  end
end
