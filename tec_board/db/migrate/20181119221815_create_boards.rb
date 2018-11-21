class CreateBoards < ActiveRecord::Migration[5.2]
  def change
    create_table :boards do |t|
      t.references :user, foreign_key: true
      t.text :content

      t.timestamps
    end
  end
end
