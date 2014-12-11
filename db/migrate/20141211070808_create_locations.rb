class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :name
      t.string :description
      t.text :content
      t.string :image
      t.string :author
      t.integer :view
      t.integer :province_id

      t.timestamps
    end
  end
end

