load Rails.root.join "config/routes/api1_routes.rb"

Rails.application.routes.draw do
  extend Api1Routes
  apipie

  api1_routes

  namespace :api, constraints: {format: 'json'} do
    namespace :v1 do
      api1_routes
    end

    namespace :w1 do
      api1_routes
    end
  end

end
