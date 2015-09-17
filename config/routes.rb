Rails.application.routes.draw do
  apipie

  namespace :api, constraints: {format: 'json'} do
    namespace :v1 do
      resource :account, only: [:show, :create, :update, :destroy]

      resources :teams, only: [:index, :show, :create, :update, :destroy] do
        # チームプランの変更
        resource :plan, only: [:show, :update]
        # チーム参加
        resources :users, only: [:index, :show, :create, :update, :destroy]
        # プロジェクト
        resources :projects, only: [:index, :show, :create, :update, :destroy] do
          # プロジェクト参加
          resources :users, only: [:index, :show, :create, :update, :destroy]
          # プロダクトバックログ
          resources :tickets, only: [:index, :show, :create, :update, :destroy]
          # スプリントバックログ
          resources :tasks, only: [:index, :show, :create, :update, :destroy]
          # バグバックログ
          resources :issues, only: [:index, :show, :create, :update, :destroy]
        end
      end

    end
  end
end
