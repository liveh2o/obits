class AddDeltaToObituaries < ActiveRecord::Migration
  def self.up
    add_column :obituaries, :delta, :boolean, :default => true, :null => false
  end

  def self.down
    remove_column :obituaries
  end
end
