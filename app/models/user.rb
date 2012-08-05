class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  # Setup accessible (or protected) attributes for your model
  #attr_accessor :password, :password_confirmation, :current_password
  attr_accessible :email, :password, :password_confirmation, :current_password, :remember_me, 
                  :first_name, :last_name, :role_ids

  #validates_presence_of :username
  #validates_uniqueness_of :username, :case_sensitive => false

  has_many :assignments
  has_many :roles, :through => :assignments



  def has_role?(role_sym)
    roles.any? { |r| r.name.underscore.to_sym == role_sym }
  end

  after_create :assign_role

  def assign_role
    self.roles << Role.find(2)
  end

  def send_reset_password_instructions
    super if invitation_token.nil?
  end
end
