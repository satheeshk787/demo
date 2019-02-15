class CreateQuestionAnswerLists < ActiveRecord::Migration
  def change
    create_table :question_answer_lists do |t|
      t.integer :question_id
      t.text :answer

      t.timestamps null: false
    end
  end
end
