class CreateSpots < ActiveRecord::Migration[5.0]
  def change
    create_table :spots do |t|
      t.text :description
      t.string :address
      t.string :name
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
