# frozen_string_literal: true

class CreateMessages < ActiveRecord::Migration[6.1]
  def change
    create_table :messages do |t|
      t.string :key, unique: true
      t.string :value

      t.timestamps
    end
  end
end
