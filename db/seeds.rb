# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Emanuel', :city => cities.first)

ActiveRecord::Base.connection.execute("Truncate roles")
Role.create!(:name => "admin")
Role.create!(:name => "subsciber")

ActiveRecord::Base.connection.execute("Truncate users")
user = User.new :first_name => "Admin", :email => "admin@test.com", :password => "admin123", :password_confirmation => "admin123"
user.save!
user.confirm!

ActiveRecord::Base.connection.execute("Truncate assignments")
assigment = Assignment.find_or_initialize_by_user_id(User.first.id)
assigment.role_id = 1
assigment.save!
