class ProductsUsers < ActiveRecord::Migration
  def change
    create_table :products_users, :id => false do |t|
      t.belongs_to :product
      t.belongs_to :user
    end
    add_index :products_users, [:product_id, :user_id]
  end
end
