class CreateQuestionOptions < ActiveRecord::Migration
  def change
    create_table :question_options do |t|
      t.string :content
      t.boolean :is_correct
      t.references :question, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
