class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.integer :type
      t.references :user, index: true, foreign_key: true
      t.string :target_id

      t.timestamps null: false
    end
  end
end
