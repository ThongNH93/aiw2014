class CreateTopImages < ActiveRecord::Migration
  def change
    create_table :top_images do |t|
      t.string :image

      t.timestamps
    end
  end
end
