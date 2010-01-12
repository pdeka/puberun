class CreateFeeds < ActiveRecord::Migration
  def self.up
    create_table :feeds do |t|
      t.text :title       
      t.text :pubDate     
      t.text :link        
      t.text :guid        
      t.text :description 
      t.text :creator     
    end
  end

  def self.down
    drop_table :feeds
  end
end
