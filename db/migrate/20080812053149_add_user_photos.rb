class AddUserPhotos < ActiveRecord::Migration
  def self.up
      change_table :users do |t|
        t.column :photo_link, :string, :limit => 2047
      end
  end

  def self.down
      change_table :users do |t|
        t.remove :photo_link
      end
  end
end
