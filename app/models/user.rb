class User < ActiveRecord::Base
  include User::Omniauth
  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :omniauthable
end
