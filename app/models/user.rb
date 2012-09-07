# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default("")
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  confirmation_token     :string(255)
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  admin                  :boolean          default(FALSE)
#  first_name             :string(255)
#  last_name              :string(255)
#  username               :string(255)
#  invitation_token       :string(60)
#  invitation_sent_at     :datetime
#  invitation_accepted_at :datetime
#  invitation_limit       :integer
#  invited_by_id          :integer
#  invited_by_type        :string(255)
#  facebook_id            :string(255)
#  facebook_link          :string(255)
#  twitter_id             :string(255)
#  twitter_link           :string(255)
#  google_id              :string(255)
#  google_link            :string(255)
#  linkedin_id            :string(255)
#  linkedin_link          :string(255)
#

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  devise :invitable, :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable, :confirmable, :omniauthable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :current_password, :confirmed_at, :remember_me, :first_name, :last_name, :role_ids, :facebook_id, :twitter_id, :google_id, :linkedin_id, :facebook_link, :twitter_link, :google_link, :linkedin_link, :username

  attr_accessor  :provider
  attr_protected :provider

  has_many :assignments
  has_many :roles, :through => :assignments

  validates :username, :presence => true
  validates :username, :facebook_id, :twitter_id, :google_id, :linkedin_id, :uniqueness => true, :allow_nil => true

  def has_role?(role_sym)
    roles.any? { |r| r.name.underscore.to_sym == role_sym }
  end

  after_create :assign_role

  def assign_role
    self.roles << Role.find_by_name('subscriber')
  end

  def send_reset_password_instructions
    super if invitation_token.nil?
  end

  def self.find_for_facebook_oauth(access_token)
    data = access_token.extra.raw_info
    if user = self.find_by_facebook_id(data.id)
      user
    end
  end

  def self.find_for_twitter_oauth(access_token)
    data = access_token.extra.raw_info

    if user = self.find_by_twitter_id(data.id)
      user
    end
  end

  def self.find_for_google_oauth(access_token)
    data = access_token.extra.raw_info

    if user = self.find_by_google_id(data.id)
      user
    end
  end

  def self.find_for_linkedin_oauth(access_token)
    data = access_token.extra.raw_info

    if user = self.find_by_linkedin_id(data.id)
      user
    end
  end

end
