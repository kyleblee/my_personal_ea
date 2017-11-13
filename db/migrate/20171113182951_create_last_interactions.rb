class CreateLastInteractions < ActiveRecord::Migration[5.1]
  def change
    create_table :last_interactions do |t|
      t.string :date
      t.string :details
      t.integer :contact_id
    end
  end
end
