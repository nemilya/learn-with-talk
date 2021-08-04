require 'sequel'

DB = Sequel.sqlite('database.db')

DB.create_table :users do
  primary_key :id
  String      :name, :unique => true, :null => false
  DateTime    :created_at
  
#  index :created_at
end

DB.create_table :contents do
  primary_key :id
  foreign_key :user_id, :users
  String      :title
  String      :url
  String      :transcript, text: true 
  Integer     :content_group_id
end

# DB.alter_table(:contents) do
#  add_column :content_group_id, Integer
# end

DB.create_table :content_groups do
  primary_key :id
  foreign_key :user_id, :users
  String      :title
  DateTime    :created_at
end

DB.create_table :words do
  primary_key :id
  foreign_key :content_id, :contents
  String      :word
  String      :translation
  Integer     :subtitle_line_pos
  DateTime    :created_at
end

# DB.drop_table(:words)

