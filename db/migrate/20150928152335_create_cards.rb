class CreateCards < ActiveRecord::Migration
  def change
    create_table :cards do |t|
      t.references :project, index: true, foreign_key: true
      t.references :sprint, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
      t.string :state
      t.string :name
      t.text :comment

      t.timestamps null: false
    end
  end
end
