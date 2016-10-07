class Column < ActiveRecord::Migration[5.0]
  def change
    add_column :albums, :band_id, :integer
    add_index :albums , :band_id
    add_column :tracks, :album_id, :integer
    add_index :tracks, :album_id
  end
end
