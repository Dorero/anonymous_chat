class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.integer :age
      t.integer :gender, default: 0
      t.belongs_to :chat
      t.timestamps
    end
  end
end
