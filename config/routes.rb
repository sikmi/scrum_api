load Rails.root.join "config/routes/api1_routes.rb"
load Rails.root.join "config/routes/admin_routes.rb"
load Rails.root.join "config/routes/public_routes.rb"

Rails.application.routes.draw do
  extend Api1Routes
  extend AdminRoutes
  extend PublicRoutes
  apipie

  root to: 'welcome#landing'

  namespace :admin do
    admin_routes
  end

  namespace :public do
    public_routes
  end

  namespace :api, constraints: {format: 'json'} do
    namespace :v1 do
      api1_routes
    end

    namespace :w1 do
      api1_routes
    end
  end

end
