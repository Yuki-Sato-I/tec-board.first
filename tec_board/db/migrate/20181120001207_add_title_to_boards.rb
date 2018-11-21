class AddTitleToBoards < ActiveRecord::Migration[5.2]
  def change
    add_column :boards, :title, :string
  end
end
