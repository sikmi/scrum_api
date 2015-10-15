module AdminRoutes
  def admin_routes
    resources :projects, param: :cd, only: [:new, :create, :edit, :update]
  end
end
