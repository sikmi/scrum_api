class Card < ActiveRecord::Base
  belongs_to :project
  belongs_to :sprint
  belongs_to :user
end
