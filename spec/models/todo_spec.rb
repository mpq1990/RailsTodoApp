require 'rails_helper'

RSpec.describe Todo, type: :model do
  
  # ensures that todo has a 1:many relationship with item
  it { should have_many(:items).dependent(:destroy) }

  # validates model is not saved without title and created_by present
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:created_by) }

end
