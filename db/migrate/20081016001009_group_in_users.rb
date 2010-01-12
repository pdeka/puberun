class GroupInUsers < ActiveRecord::Migration
    def self.up
        change_table :users do |t|
            t.column :usergroup, :int
        end
    end

    def self.down
        change_table :users do |t|
            t.remove :usergroup
        end
    end
end
