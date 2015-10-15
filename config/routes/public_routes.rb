module PublicRoutes
  def public_routes
    resources :projects, param: :project_cd, only: [:show] do
      resources :sprints, only: [:show]
      resources :cards, only: [:show]
    end
  end
end
