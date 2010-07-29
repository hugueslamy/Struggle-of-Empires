class CreatePropositions < ActiveRecord::Migration
  def self.up
    create_table :propositions do |t|
      t.integer :playing_id
      t.integer :game_id
      t.integer :war
      t.integer :round
      t.string :positionA
      t.string :positionB
      t.integer :amount
      t.boolean :opened
      t.boolean :rejected

      t.timestamps
    end
  end

  def self.down
    drop_table :propositions
  end
end
