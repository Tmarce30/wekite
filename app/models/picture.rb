class Picture < ApplicationRecord
  belongs_to :user
  belongs_to :spot

  has_attachments :photos
end
