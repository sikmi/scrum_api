class Project < ActiveRecord::Base
  include BaseModel

  # url のパラメータ変更
  def to_param
    return cd
  end
end
