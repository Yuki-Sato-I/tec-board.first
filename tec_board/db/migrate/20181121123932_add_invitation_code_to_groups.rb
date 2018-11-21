class AddInvitationCodeToGroups < ActiveRecord::Migration[5.2]
  def change
    add_column :groups, :invitation_code, :string
  end
end
