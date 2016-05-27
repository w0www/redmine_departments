class AddDepartments < ActiveRecord::Migration
  def self.up
    create_table :departments, :force => true do |t|
      t.string "nombre", :limit => 100, :null => false
      t.string "codigo", :limit => 10, :null => true, :default => nil
      t.string "direccion", :limit => 100, :null => false
      t.string "direccion2", :limit => 100, :null => false
      t.string "codigo_postal", :limit => 100, :null => false
      t.string "localidad", :limit => 100, :null => false
      t.string "territorio", :limit => 100, :null => false
      t.string "telefono", :limit => 100, :null => false
      t.string "fax", :limit => 100, :null => false
      t.string "email_oficina", :limit => 100, :null => false
      t.string "telefono_vigilante", :limit => 100, :null => false
      t.string "responsable_sepe", :limit => 100, :null => false
      t.string "telefono_responsable_sepe", :limit => 100, :null => false
      t.string "email_responsable_sepe", :limit => 100, :null => false
      t.string "anotaciones", :limit => 100, :null => false
      t.integer "responsable_id"
      t.integer "coordinador_id"
    end

    add_index :departments, :responsable_id
    add_index :departments, :coordinador_id
  end

  def self.down
    remove_index :departments, :column => :responsable_id
    remove_index :departments, :column => :coordinador_id

    drop_table :departments
  end
end
