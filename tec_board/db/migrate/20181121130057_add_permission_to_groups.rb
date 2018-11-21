class AddPermissionToGroups < ActiveRecord::Migration[5.2]
  def change
    add_column :groups, :permission, :boolean,default: false
  end
end
