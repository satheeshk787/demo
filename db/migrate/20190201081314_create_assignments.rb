class CreateAssignments < ActiveRecord::Migration
  def change
    create_table :assignments do |t|
      t.string :assignment_name
      t.text :description

      t.timestamps null: false
    end
  end
end
