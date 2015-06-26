class AddYoutubeUrlToShows < ActiveRecord::Migration
  def change
    add_column :shows, :youtube_url, :string
  end
end
