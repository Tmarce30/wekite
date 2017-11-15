class Photo < ApplicationRecord
  belongs_to :user_id
  belongs_to :spot_id
end
