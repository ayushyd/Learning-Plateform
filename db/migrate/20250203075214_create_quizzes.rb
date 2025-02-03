class CreateQuizzes < ActiveRecord::Migration[7.2]
  def change
    create_table :quizzes do |t|
      t.string :question
      t.string :answer
      t.integer :lesson_id

      t.timestamps
    end
  end
end
