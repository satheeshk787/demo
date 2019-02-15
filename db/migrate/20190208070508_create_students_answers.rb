class CreateStudentsAnswers < ActiveRecord::Migration
  def change
    create_table :students_answers do |t|
      t.integer :user_id
      t.integer :question_id
      t.integer :review_status
      t.integer :score

      t.timestamps null: false
    end
  end
end
