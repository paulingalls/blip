class CreateBagLocations < ActiveRecord::Migration[6.1]
  def change
    create_table :bag_locations do |t|
      t.string :location
      t.references :event, null: false, foreign_key: true
      t.references :customer, null: false, foreign_key: true

      t.timestamps
    end
  end
end
