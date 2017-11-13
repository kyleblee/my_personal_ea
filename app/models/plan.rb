class Plan < ActiveRecord::Base
  belongs_to :user
  has_many :contact_plans
  has_many :contacts, through: :contact_plans
end
