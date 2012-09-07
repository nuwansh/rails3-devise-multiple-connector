# == Schema Information
#
# Table name: assignments
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#  role_id    :integer
#

class Assignment < ActiveRecord::Base
  belongs_to :user
  belongs_to :role
end
