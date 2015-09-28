class Message < ActiveRecord::Base
  belongs_to :project
  belongs_to :user
  belongs_to :to
end
