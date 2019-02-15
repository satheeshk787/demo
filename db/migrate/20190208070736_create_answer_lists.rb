class CreateAnswerLists < ActiveRecord::Migration
  def change
    create_table :answer_lists do |t|
      t.integer :students_answer_id
      t.text :answer

      t.timestamps null: false
    end
  end
end
