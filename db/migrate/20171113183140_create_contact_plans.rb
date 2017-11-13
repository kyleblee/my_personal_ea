class CreateContactPlans < ActiveRecord::Migration[5.1]
  def change
    create_table :contact_plans do |t|
      t.integer :contact_id
      t.integer :plan_id
    end
  end
end
