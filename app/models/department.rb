class Department < ActiveRecord::Base
  has_and_belongs_to_many :issues, :join_table => "issue_has_departments"
  has_and_belongs_to_many :users
  belongs_to :responsable, :class_name => "User"
  belongs_to :coordinador, :class_name => "User"

  cattr_reader :per_page
  @@per_page = 25
  validates_presence_of :nombre, :codigo

 if ActiveRecord::VERSION::MAJOR >= 4
    has_one :avatar, lambda { where("#{Attachment.table_name}.description = 'avatar'") }, :class_name => "Attachment", :as  => :container, :dependent => :destroy
  else
    has_one :avatar, :conditions => "#{Attachment.table_name}.description = 'avatar'", :class_name => "Attachment", :as  => :container, :dependent => :destroy
  end

  acts_as_attachable :view_permission => :view_contacts,
                     :delete_permission => :edit_contacts




  def to_s
    nombre
  end
end
