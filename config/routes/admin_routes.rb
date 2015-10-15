module AdminRoutes
  def admin_routes
    resources :projects, param: :project_cd, only: [:new, :create, :edit, :update]
  end
end
