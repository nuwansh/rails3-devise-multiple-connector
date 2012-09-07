# == Schema Information
#
# Table name: roles
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  name       :string(255)
#

class Role < ActiveRecord::Base
  has_many :assignments
  has_many :users, :through => :assignments
end
