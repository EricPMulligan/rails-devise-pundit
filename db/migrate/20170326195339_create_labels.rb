class CreateLabels < ActiveRecord::Migration[5.0]
  def change
    create_table :labels do |t|
      t.references :user, foreign_key: { to_table: :users }, null: false

      t.string :name,   null: false
      t.string :colour, null: false

      t.timestamps null: false
    end

    add_index :labels, [:user_id, :name, :colour], unique: true
  end
end
