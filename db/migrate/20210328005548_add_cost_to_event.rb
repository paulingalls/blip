# frozen_string_literal: true

class AddCostToEvent < ActiveRecord::Migration[6.1]
  def change
    add_column :events, :cost, :decimal, precision: 8, scale: 2, default: 0
  end
end
