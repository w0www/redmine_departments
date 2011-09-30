class AddDepartmentsUsers < ActiveRecord::Migration
  def self.up
    create_table :departments_users, :id => false do |t|
      t.integer :department_id
      t.integer :user_id
      t.timestamps
    end
    add_index :departments_users, :user_id
    add_index :departments_users, :department_id
  end

  def self.down
    remove_index :departments_users, :column => :user_id
    remove_index :departments_users, :column => :department_id
    drop_table :departments_users
  end
end
