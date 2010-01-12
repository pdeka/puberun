class CreateVideos < ActiveRecord::Migration
  def self.up
      create_table :videos do |t|
          t.column :title, :text,  :null=>false
          t.column :link, :text,  :null=>false
          t.column :created_by, :integer, :null=>false
          t.column :created_at, :datetime, :null=>false
      end
      execute %{alter table videos
            add constraint vi_user_id
            foreign key (created_by) references users(id)}

  end

  def self.down
      drop_table :videos
  end
end
