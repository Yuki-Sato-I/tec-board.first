class AddGroupIdToBoards < ActiveRecord::Migration[5.2]
  def change
    add_column :boards, :group_id, :integer
  end
end
