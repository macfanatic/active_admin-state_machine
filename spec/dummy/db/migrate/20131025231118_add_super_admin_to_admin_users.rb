class AddSuperAdminToAdminUsers < ActiveRecord::Migration[4.2]
  def change
    add_column :admin_users, :super_admin, :boolean, default: false
  end
end
