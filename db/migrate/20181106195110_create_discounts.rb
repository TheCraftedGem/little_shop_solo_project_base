class CreateDiscounts < ActiveRecord::Migration[5.1]
  def change
    create_table :discounts do |t|
      t.float :rate
      t.integer :quantity
      t.references :item, foreign_key: true
    end
  end
end
