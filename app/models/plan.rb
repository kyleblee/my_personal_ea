class Plan < ActiveRecord::Base
  belongs_to :user
  has_many :contacts, through: :contact_plans
end
