class DropContacts < ActiveRecord::Migration
  def self.up
    remove_index :contacts, :column => :department_id
    drop_table :contacts
  end
  
  def self.down
    create_table :contacts, :force => true do |t|
      t.string "name", "email", "phone", "courses"
      t.integer "department_id"
      t.timestamps
    end
    add_index :contacts, :department_id
  end
end
