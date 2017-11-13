class CreateContacts < ActiveRecord::Migration[5.1]
  def change
    create_table :contacts do |t|
      t.string :name
      t.string :email
      t.string :phone_number
      t.string :category
      t.string :expertise
      t.string :preferences
      t.integer :user_id
    end
  end
end
