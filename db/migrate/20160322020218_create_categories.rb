class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name
      t.string :description
      t.time :time_limit
      t.integer :number_of_words_in_examination

      t.timestamps null: false
    end
  end
end
