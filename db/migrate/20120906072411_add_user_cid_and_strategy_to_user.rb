class AddUserCidAndStrategyToUser < ActiveRecord::Migration
  def change
    add_column :users, :facebook_id, :string
    add_column :users, :facebook_link, :string
    add_column :users, :twitter_id, :string
    add_column :users, :twitter_link, :string
    add_column :users, :google_id, :string
    add_column :users, :google_link, :string
    add_column :users, :linkedin_id, :string
    add_column :users, :linkedin_link, :string

    add_index :users, :linkedin_id
    add_index :users, :google_id
    add_index :users, :twitter_id
    add_index :users, :facebook_id
  end
end
