class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :title
      t.string :description
      t.integer :priority
      t.date :due_date
      t.integer :user_id

      t.timestamps
    end
  end
end
