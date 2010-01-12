class AddOrderInNotes < ActiveRecord::Migration
  def self.up
      change_table :notes do |t|
        t.column :position, :integer, :limit => 11, :default => 0
      end
  end

  def self.down
      change_table :notes do |t|
        t.remove :position
      end
  end
end
