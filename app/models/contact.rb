class Contact < ActiveRecord::Base
  belongs_to :user
  has_many :plans, through: :contact_plans
end
