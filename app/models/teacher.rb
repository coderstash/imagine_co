# == Schema Information
#
# Table name: teachers
#
#  id                  :integer(4)      not null, primary key
#  first_name          :string(255)
#  last_name           :string(255)
#  email               :string(255)
#  username            :string(255)
#  crypted_password    :string(255)
#  password_salt       :string(255)
#  persistence_token   :string(255)
#  single_access_token :string(255)
#  perishable_token    :string(255)
#  login_count         :integer(4)
#  failed_login_count  :integer(4)
#  last_request_at     :datetime
#  current_login_at    :datetime
#  last_login_at       :datetime
#  current_login_ip    :string(255)
#  last_login_ip       :string(255)
#  created_at          :datetime
#  updated_at          :datetime
#  admin               :boolean(1)
#  account_id          :integer(4)
#

class Teacher < ActiveRecord::Base
  
  #Associations
  belongs_to :account
  has_many :classrooms
  has_many :curriculums
  has_many :lesson_templates, :through => :curriculums
  
  validates_presence_of :first_name, :on => :create, :message => "can't be blank"
  validates_presence_of :last_name, :on => :create, :message => "can't be blank"
  validates_uniqueness_of :email, :on => :create, :message => "must be unique"
  
  #Authlogic
  acts_as_authentic do |c|
    c.login_field = :email
    c.logged_in_timeout = 120.minutes
  end
  
  # Scopes
  scope :admin_rights, where("admin = ?", true)
  scope :account_teachers, lambda { |account_id| where("account_id = ?", account_id) }
  
  # Methods
  
  def self.setup_new_teacher(params, account)    

  end
  
  def full_name
    fullname = self.first_name + " " + self.last_name
    return fullname
  end
  
  def students
    unless self.classrooms.blank?
      students = Array.new
      self.classrooms.each do |classroom| 
        students.push(classroom.students)
      end
      flatten_students = students.flatten!
      compacted_students = flatten_students.compact
      return compacted_students
    end
  end
  
end
