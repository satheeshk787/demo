class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.integer :user_id
      t.integer :assignment_id
      t.text :question
      t.integer :choice_type

      t.timestamps null: false
    end
  end
end
