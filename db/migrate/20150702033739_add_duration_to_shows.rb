class AddDurationToShows < ActiveRecord::Migration
  def change
    add_column :shows, :duration, :integer, default: 0
  end
end
