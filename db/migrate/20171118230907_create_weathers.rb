class CreateWeathers < ActiveRecord::Migration[5.0]
  def change
    create_table :weathers do |t|
      t.references :spot, foreign_key: true
      t.string :weather_desc
      t.string :air_temp
      t.string :wind_speed
      t.string :wind_dir
      t.string :water_temp

      t.timestamps
    end
  end
end
