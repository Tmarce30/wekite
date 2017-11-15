class CreatePhotos < ActiveRecord::Migration[5.0]
  def change
    create_table :photos do |t|
      t.references :user_id, foreign_key: true
      t.references :spot_id, foreign_key: true

      t.timestamps
    end
  end
end
