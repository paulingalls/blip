class AddClaimNumberToBagLocation < ActiveRecord::Migration[6.1]
  def change
    add_column :bag_locations, :claim_number, :integer
  end
end
