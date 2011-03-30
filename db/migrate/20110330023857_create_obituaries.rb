class CreateObituaries < ActiveRecord::Migration
  def self.up
    create_table :obituaries do |t|
      t.string :last_name
      t.string :first_name
      t.string :middle_name
      t.string :other_name
      t.date :printed_on
      t.string :page
      t.date :born_on
      t.date :died_on
      t.text :notes
      t.boolean :dirty

      t.timestamps
    end
  end

  def self.down
    drop_table :obituaries
  end
end
