class AddLockedToEvent < ActiveRecord::Migration[6.1]
  def change
    add_column :events, :locked, :boolean, default: false
  end
end
