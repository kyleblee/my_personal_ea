class User < ActiveRecord::Base
  has_secure_password
  has_many :contacts
  has_many :plans
  has_many :last_interactions, through: :contacts
end
