class CreateBuilds < ActiveRecord::Migration
  def change
    create_table :builds do |t|
      t.string :title
      t.integer :budget
      t.integer :user_id
    end
  end
end
