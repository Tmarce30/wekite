class AddWeatherCodeToWeathers < ActiveRecord::Migration[5.0]
  def change
    add_column :weathers, :code, :string
  end
end
