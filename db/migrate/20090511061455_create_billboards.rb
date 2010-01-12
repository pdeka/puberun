class CreateBillboards < ActiveRecord::Migration
  def self.up
    create_table :billboards do |t|
      t.string :title
      t.text :body
      t.integer :position, :limit => 11, :default => 0
      t.timestamps
    end
  end

  def self.down
    drop_table :billboards
  end
end
