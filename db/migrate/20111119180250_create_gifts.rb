class CreateGifts < ActiveRecord::Migration
  def change
    create_table :gifts do |t|
      t.string :type
      t.integer :value
      t.integer :gifter_id
      t.integer :giftee_id
      t.string :message
      t.integer :company_id

      t.timestamps
    end
  end
end
