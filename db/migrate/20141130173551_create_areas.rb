class CreateAreas < ActiveRecord::Migration
  Area.create!(name: 'NORTHERN VIETNAM' ) if direction == :up
  Area.create!(name: 'CENTRAL VIETNAM' ) if direction == :up
  Area.create!(name: 'SOUTHERN VIETNAM' ) if direction == :up

  def change
    create_table :areas do |t|
      t.string :name

      t.timestamps
    end
  end
end
