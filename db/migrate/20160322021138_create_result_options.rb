class CreateResultOptions < ActiveRecord::Migration
  def change
    create_table :result_options do |t|
      t.string :content
      t.references :question_option, index: true, foreign_key: true
      t.references :result, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
