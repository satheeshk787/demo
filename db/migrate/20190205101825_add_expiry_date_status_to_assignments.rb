class AddExpiryDateStatusToAssignments < ActiveRecord::Migration
  def change
    add_column :assignments, :expiry_date, :date
    add_column :assignments, :status, :integer, default: 1
  end
end
