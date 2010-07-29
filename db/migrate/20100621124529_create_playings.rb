class CreatePlayings < ActiveRecord::Migration
  def self.up
    create_table :playings do |t|
      t.integer :user_id
      t.integer :game_id
      
      t.string :country
      t.integer :play_order
      t.boolean :pass, :default => false

      t.timestamps
    end
  end

  def self.down
    drop_table :playings
  end
end
