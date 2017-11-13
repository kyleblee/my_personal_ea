class ContactPlan < ActiveRecord::Base
  belongs_to :plan
  belongs_to :contact
end
