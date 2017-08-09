require 'rails_helper'

RSpec.describe Tag, type: :model do
  before(:each) do
    @category = FactoryGirl.create(:tag)
  end

  it "is valid with valid attributes" do
    expect(@category).to be_valid
  end

  it "is not valid without a name" do
    expect(Tag.new(description: Faker::Lorem.paragraph)).not_to be_valid
  end
  
  it "has been removed" do
    expect { @category.destroy }.to change(Tag, :count).by(-1)
  end
end