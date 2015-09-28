class CreatePlans < ActiveRecord::Migration
  def change
    create_table :plans do |t|
      t.string :name
      t.text :comment
      t.integer :price

      t.timestamps null: false
    end
  end
end
