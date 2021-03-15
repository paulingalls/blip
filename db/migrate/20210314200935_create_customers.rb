class CreateCustomers < ActiveRecord::Migration[6.1]
  def change
    create_table :customers do |t|
      t.string :first_name
      t.string :last_name
      t.string :phone_number

      t.timestamps
    end
    add_index :customers, :phone_number, unique: true
  end
end
