class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.string :name
      t.string :domain
      t.float :budget

      t.timestamps
    end
  end
end
