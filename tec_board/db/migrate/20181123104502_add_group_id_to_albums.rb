class AddGroupIdToAlbums < ActiveRecord::Migration[5.2]
  def change
    add_column :albums, :group_id, :integer
  end
end
