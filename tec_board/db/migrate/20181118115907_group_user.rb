class GroupUser < ActiveRecord::Migration[5.2]
  def change
    create_table :group_users do |t|
      t.references :user, index: true, foreign_key: { on_delete: :cascade }
 
      t.references :group, index: true, foreign_key: { on_delete: :cascade }

      t.timestamps
    end
  end
end
#削除ずみ