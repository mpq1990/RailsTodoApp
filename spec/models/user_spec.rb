require 'rails_helper'

RSpec.describe User, type: :model do
  # ensures that todo has a 1:many relationship with item
  it { should have_many(:todos) }

  # validates model is not saved without title and created_by present
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password_digest) }
end
