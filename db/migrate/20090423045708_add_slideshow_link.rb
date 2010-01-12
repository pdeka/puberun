class AddSlideshowLink < ActiveRecord::Migration
  def self.up
    change_table :photos do |t|
      t.column :slideshow, :string, :null=>false
    end
  end

  def self.down
    change_table :photos do |t|
      t.remove :slideshow
    end
  end
end
