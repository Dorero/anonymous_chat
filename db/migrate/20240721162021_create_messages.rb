class CreateMessages < ActiveRecord::Migration[7.1]
  def change
    create_table :messages do |t|
      t.text :content
      t.belongs_to :user
      t.belongs_to :chat
      t.timestamps
    end
  end
end
