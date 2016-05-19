class Department < ActiveRecord::Base
  has_and_belongs_to_many :issues, :join_table => "issue_has_departments"
  has_and_belongs_to_many :users

  cattr_reader :per_page
  @@per_page = 25
  validates_presence_of :name

 if ActiveRecord::VERSION::MAJOR >= 4
    has_one :avatar, lambda { where("#{Attachment.table_name}.description = 'avatar'") }, :class_name => "Attachment", :as  => :container, :dependent => :destroy
    has_one :address, lambda { where(:address_type => "business") }, :dependent => :destroy, :as => :addressable, :class_name => "Address"
  else
    has_one :avatar, :conditions => "#{Attachment.table_name}.description = 'avatar'", :class_name => "Attachment", :as  => :container, :dependent => :destroy
    has_one :address, :conditions => {:address_type => "business"}, :dependent => :destroy, :as => :addressable, :class_name => "Address"
  end

  def to_s
    name
  end
end
