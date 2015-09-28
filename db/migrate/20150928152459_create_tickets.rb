class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      t.references :project, index: true, foreign_key: true
      t.references :sprint, index: true, foreign_key: true
      t.references :card, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
      t.string :name
      t.text :comment
      t.string :state

      t.timestamps null: false
    end
  end
end
