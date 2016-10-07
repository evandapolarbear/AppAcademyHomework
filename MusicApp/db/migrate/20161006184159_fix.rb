class Fix < ActiveRecord::Migration[5.0]
  def change
    remove_index :tracks, :album_id
    remove_index :albums, :band_id
    add_index :tracks, :album_id
    add_index :albums, :band_id
  end
end
