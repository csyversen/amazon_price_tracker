class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.string :sale_site
      t.text :url

      t.timestamps
    end
  end
end
