class Contact < ActiveRecord::Base
  belongs_to :user
  has_many :last_interactions
  has_many :contact_plans
  has_many :plans, through: :contact_plans
end
