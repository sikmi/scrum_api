class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :state
      t.string :name
      t.string :cd
      t.text :comment

      t.timestamps null: false
    end
  end
end
