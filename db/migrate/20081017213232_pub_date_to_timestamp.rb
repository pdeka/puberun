class PubDateToTimestamp < ActiveRecord::Migration
  def self.up
      execute %{alter table feeds
      modify column pubDate timestamp not null}

      execute %{alter table feeds
      modify column link text not null}

      execute %{alter table feeds
      modify column guid text not null}

  end

  def self.down
      execute %{alter table feeds
      modify column pubDate text not null}
  end
end
