class CreateResults < ActiveRecord::Migration
  def change
    create_table :results do |t|
      t.integer :status
      t.boolean :is_correct
      t.string :content
      t.references :question, index: true, foreign_key: true
      t.references :examination, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
