class AddGroupIdToChats < ActiveRecord::Migration[5.2]
  def change
    add_column :chats, :group_id, :integer
  end
end
