class CreateGames < ActiveRecord::Migration
  def self.up
    create_table :games do |t|
      t.string :name
      t.integer :war, :default => 1
      t.integer :round, :default => 1

      t.timestamps
    end
  end

  def self.down
    drop_table :games
  end
end
