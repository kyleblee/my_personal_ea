class CreatePlans < ActiveRecord::Migration[5.1]
  def change
    create_table :plans do |t|
      t.string :name
      t.string :date
      t.string :time
      t.string :location
      t.string :context
      t.string :pre_notes
      t.string :post_notes
      t.integer :user_id
    end
  end
end
