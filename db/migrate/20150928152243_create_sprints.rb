class CreateSprints < ActiveRecord::Migration
  def change
    create_table :sprints do |t|
      t.references :project, index: true, foreign_key: true
      t.string :state
      t.string :name
      t.date :started_at
      t.date :finished_at
      t.integer :point

      t.timestamps null: false
    end
  end
end
