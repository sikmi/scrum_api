class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.references :project, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
      t.references :to, polymorphic: true, index: true
      t.text :comment

      t.timestamps null: false
    end
  end
end
