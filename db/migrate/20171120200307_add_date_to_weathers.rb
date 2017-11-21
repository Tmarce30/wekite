class AddDateToWeathers < ActiveRecord::Migration[5.0]
  def change
    add_column :weathers, :date, :string
  end
end
