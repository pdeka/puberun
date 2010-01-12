class CreatePhotos < ActiveRecord::Migration
    def self.up
        create_table :photos do |t|
            t.column :title, :text,  :null=>false
            t.column :link, :text,  :null=>false
            t.column :created_by, :integer, :null=>false
            t.column :created_at, :datetime, :null=>false
        end
        execute %{alter table photos
              add constraint ph_user_id
              foreign key (created_by) references users(id)}

        execute %{alter table users
              drop column photo_link
              }

    end

    def self.down
        drop_table :photos
        change_table :users do |t|
            t.column :photo_link, :string, :limit => 2047
        end
    end

end
