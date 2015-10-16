class Admin::ProjectsController < Admin::ApplicationController 
  include CrudController
  crud_controller Project, [:index,:new,:create,:edit,:update,:destroy]

  def pb
  end

end
