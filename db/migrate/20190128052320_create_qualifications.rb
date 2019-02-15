class CreateQualifications < ActiveRecord::Migration
  def change
    create_table :qualifications do |t|
      t.integer :user_id
      t.string :stream
      t.string :subject
      t.date :completed

      t.timestamps null: false
    end
  end
end
