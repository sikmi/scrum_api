module AdminRoutes
  def admin_routes
    resources :projects, param: :cd, only: [:index, :new, :create, :edit, :update] do
      get 'pb', :on => :member
    end
  end
end
