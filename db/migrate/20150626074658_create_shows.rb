class CreateShows < ActiveRecord::Migration
  def change
    create_table :shows do |t|
      t.string :title
      t.text :description
      t.string :video
      t.string :thumbnail
      t.string :attachment

      t.timestamps null: false
    end
  end
end
