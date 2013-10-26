class AddSuperAdminToAdminUsers < ActiveRecord::Migration
  def change
    add_column :admin_users, :super_admin, :boolean, default: false
  end
end
