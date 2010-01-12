# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20090511061455) do

  create_table "billboards", :force => true do |t|
    t.string   "title"
    t.text     "body"
    t.integer  "position",   :limit => 11, :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "feeds", :force => true do |t|
    t.text      "title"
    t.timestamp "pubDate",     :null => false
    t.text      "link",        :null => false
    t.text      "guid",        :null => false
    t.text      "description"
    t.text      "creator"
  end

  create_table "forums", :force => true do |t|
    t.integer "site_id",          :limit => 11
    t.string  "name"
    t.string  "description"
    t.integer "topics_count",     :limit => 11, :default => 0
    t.integer "posts_count",      :limit => 11, :default => 0
    t.integer "position",         :limit => 11, :default => 0
    t.text    "description_html"
    t.string  "state",                          :default => "public"
    t.string  "permalink"
  end

  add_index "forums", ["position", "site_id"], :name => "index_forums_on_position_and_site_id"
  add_index "forums", ["site_id", "permalink"], :name => "index_forums_on_site_id_and_permalink"

  create_table "moderatorships", :force => true do |t|
    t.integer  "forum_id",   :limit => 11
    t.integer  "user_id",    :limit => 11
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "monitorships", :force => true do |t|
    t.integer  "user_id",    :limit => 11
    t.integer  "topic_id",   :limit => 11
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "active",                   :default => true
  end

  create_table "musics", :force => true do |t|
    t.text     "title",                    :null => false
    t.text     "link",                     :null => false
    t.string   "music_type",               :null => false
    t.integer  "created_by", :limit => 11, :null => false
    t.datetime "created_at",               :null => false
  end

  add_index "musics", ["created_by"], :name => "mu_user_id"

  create_table "notes", :force => true do |t|
    t.text     "body"
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "position",   :limit => 11, :default => 0
  end

  create_table "photos", :force => true do |t|
    t.text     "title",                    :null => false
    t.text     "link",                     :null => false
    t.integer  "created_by", :limit => 11, :null => false
    t.datetime "created_at",               :null => false
    t.string   "slideshow",                :null => false
  end

  add_index "photos", ["created_by"], :name => "ph_user_id"

  create_table "posts", :force => true do |t|
    t.integer  "user_id",    :limit => 11
    t.integer  "topic_id",   :limit => 11
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "forum_id",   :limit => 11
    t.text     "body_html"
    t.integer  "site_id",    :limit => 11
  end

  add_index "posts", ["created_at", "forum_id"], :name => "index_posts_on_forum_id"
  add_index "posts", ["created_at", "user_id"], :name => "index_posts_on_user_id"
  add_index "posts", ["created_at", "topic_id"], :name => "index_posts_on_topic_id"

  create_table "sites", :force => true do |t|
    t.string   "name"
    t.string   "host"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "topics_count", :limit => 11, :default => 0
    t.integer  "users_count",  :limit => 11, :default => 0
    t.integer  "posts_count",  :limit => 11, :default => 0
  end

  create_table "temp_users", :force => true do |t|
    t.string   "login"
    t.string   "email"
    t.string   "crypted_password",          :limit => 40
    t.string   "salt",                      :limit => 40
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token"
    t.datetime "remember_token_expires_at"
    t.string   "activation_code",           :limit => 40
    t.datetime "activated_at"
    t.string   "state",                                     :default => "passive"
    t.datetime "deleted_at"
    t.boolean  "admin",                                     :default => false
    t.integer  "site_id",                   :limit => 11
    t.datetime "last_login_at"
    t.text     "bio_html"
    t.string   "openid_url"
    t.datetime "last_seen_at"
    t.string   "website"
    t.integer  "posts_count",               :limit => 11,   :default => 0
    t.string   "bio"
    t.string   "display_name"
    t.string   "permalink"
    t.string   "photo_link",                :limit => 2047
  end

  create_table "topics", :force => true do |t|
    t.integer  "forum_id",        :limit => 11
    t.integer  "user_id",         :limit => 11
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "hits",            :limit => 11, :default => 0
    t.integer  "sticky",          :limit => 11, :default => 0
    t.integer  "posts_count",     :limit => 11, :default => 0
    t.boolean  "locked",                        :default => false
    t.integer  "last_post_id",    :limit => 11
    t.datetime "last_updated_at"
    t.integer  "last_user_id",    :limit => 11
    t.integer  "site_id",         :limit => 11
    t.string   "permalink"
  end

  add_index "topics", ["sticky", "last_updated_at", "forum_id"], :name => "index_topics_on_sticky_and_last_updated_at"
  add_index "topics", ["last_updated_at", "forum_id"], :name => "index_topics_on_forum_id_and_last_updated_at"
  add_index "topics", ["forum_id", "permalink"], :name => "index_topics_on_forum_id_and_permalink"

  create_table "users", :force => true do |t|
    t.string   "login"
    t.string   "email"
    t.string   "crypted_password",          :limit => 40
    t.string   "salt",                      :limit => 40
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token"
    t.datetime "remember_token_expires_at"
    t.string   "activation_code",           :limit => 40
    t.datetime "activated_at"
    t.string   "state",                                   :default => "passive"
    t.datetime "deleted_at"
    t.boolean  "admin",                                   :default => false
    t.integer  "site_id",                   :limit => 11
    t.datetime "last_login_at"
    t.text     "bio_html"
    t.string   "openid_url"
    t.datetime "last_seen_at"
    t.string   "website"
    t.integer  "posts_count",               :limit => 11, :default => 0
    t.string   "bio"
    t.string   "display_name"
    t.string   "permalink"
    t.integer  "usergroup",                 :limit => 11
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size",          :limit => 11
    t.datetime "avatar_updated_at"
  end

  add_index "users", ["last_seen_at"], :name => "index_users_on_last_seen_at"
  add_index "users", ["site_id", "posts_count"], :name => "index_site_users_on_posts_count"
  add_index "users", ["site_id", "permalink"], :name => "index_site_users_on_permalink"

  create_table "videos", :force => true do |t|
    t.text     "title",                    :null => false
    t.text     "link",                     :null => false
    t.integer  "created_by", :limit => 11, :null => false
    t.datetime "created_at",               :null => false
  end

  add_index "videos", ["created_by"], :name => "vi_user_id"

end
