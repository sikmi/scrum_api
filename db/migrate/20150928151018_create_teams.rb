class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.string :name
      t.text :comment
      t.references :plan, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
