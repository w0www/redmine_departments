class AddDepartments < ActiveRecord::Migration
  def self.up
    create_table :departments, :force => true do |t|
      t.string "name", :limit => 100, :null => false
      t.string "code", :limit => 10, :null => true, :default => nil
      t.string "avatar"

    end
  end

  def self.down
    drop_table :departments
  end
end
