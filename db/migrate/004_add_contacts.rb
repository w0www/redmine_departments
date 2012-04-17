class AddContacts < ActiveRecord::Migration
  def self.up
    remove_column :departments, :contact_names
    remove_column :departments, :contact_emails
    remove_column :departments, :contact_phones
    remove_column :departments, :course_names

    create_table :contacts, :force => true do |t|
      t.string "name", "email", "phone", "courses"
      t.integer "department_id"
      t.timestamps
    end
    add_index :contacts, :department_id
  end

  def self.down
    remove_index :contacts, :column => :department_id
    drop_table :contacts

    add_column :departments, :contact_phones, :string, { :limit => 200, :null => false, :default => '' }
    add_column :departments, :contact_emails, :string, { :limit => 200, :null => false, :default => '' }
    add_column :departments, :contact_names, :string, { :limit => 200, :null => false, :default => '' }
    add_column :departments, :course_names, :string,  { :limit => 200, :null => false, :default => ''}
  end
end
