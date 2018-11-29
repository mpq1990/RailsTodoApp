class Item < ApplicationRecord
  # association
  belongs_to :todo

  # validation
  validates_presence_of :name
end
