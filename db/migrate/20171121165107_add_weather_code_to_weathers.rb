class AddWeatherCodeToWeathers < ActiveRecord::Migration[5.0]
  def change
    add_column :weathers, :weather_code, :string
  end
end
