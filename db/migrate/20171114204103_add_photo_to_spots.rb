class AddPhotoToSpots < ActiveRecord::Migration[5.0]
  def change
    add_column :spots, :photo, :string
  end
end
