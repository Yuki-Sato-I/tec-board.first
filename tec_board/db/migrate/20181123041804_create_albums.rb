class CreateAlbums < ActiveRecord::Migration[5.2]
  def change
    create_table :albums do |t|
      t.string :title
      t.text :content
      t.json :images

      t.timestamps
    end
  end
end
