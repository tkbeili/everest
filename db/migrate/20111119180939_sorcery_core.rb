class SorceryCore < ActiveRecord::Migration
  def self.up
    create_table :employees do |t|
      t.string :email,            :null => false # if you use this field as a username, you might want to make it :null => false.
      t.string :crypted_password, :default => nil
      t.string :salt,             :default => nil

      t.string :first_name
      t.string :last_name
      
      t.string :emp_id
      t.integer :manager_id
      t.boolean :is_admin
      t.integer :company_id


      t.timestamps
    end
  end

  def self.down
    drop_table :employees
  end
end