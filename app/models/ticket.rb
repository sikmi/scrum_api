class Ticket < ActiveRecord::Base
  belongs_to :project
  belongs_to :sprint
  belongs_to :card
  belongs_to :user
end
