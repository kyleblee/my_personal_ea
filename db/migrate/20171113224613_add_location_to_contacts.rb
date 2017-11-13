class AddLocationToContacts < ActiveRecord::Migration[5.1]
  def change
    add_column :contacts, :location, :string
  end
end
