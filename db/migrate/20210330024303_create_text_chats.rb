class CreateTextChats < ActiveRecord::Migration[6.1]
  def change
    create_table :text_chats do |t|
      t.string :message_text, null: false
      t.references :customer, null: false, foreign_key: true
      t.boolean :response, default: false

      t.timestamps
    end
  end
end
