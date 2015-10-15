module AdminRoutes
  def admin_routes
    resources :projects, only: [:new, :create, :edit, :update]
  end
end
