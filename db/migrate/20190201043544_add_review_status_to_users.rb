class AddReviewStatusToUsers < ActiveRecord::Migration
  def change
    add_column :users, :review_status, :integer, default: 0
  end
end
