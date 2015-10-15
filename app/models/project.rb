class Project < ActiveRecord::Base

  # url のパラメータ変更
  def to_param
    return cd
  end
end
