require 'rails_helper'

RSpec.describe Item, type: :model do
  
  # ensures that the item belongs to one todo
  it { should belong_to(:todo) }

  # validate that column :name is present before model is saved
  it { should validate_presence_of(:name) }
end
