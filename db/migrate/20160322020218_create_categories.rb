class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name
      t.string :description
      t.integer :time_limit, default: 0
      t.integer :number_of_questions_in_examination

      t.timestamps null: false
    end
  end
end
