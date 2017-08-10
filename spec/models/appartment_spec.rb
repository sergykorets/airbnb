require 'rails_helper'

RSpec.describe Appartment, type: :model do
  before(:each) do
    @author = FactoryGirl.create(:author)
    @appartment = FactoryGirl.create(:appartment, author: @author)
  end

  it "is valid with valid attributes" do
    expect(@appartment).to be_valid
  end

  it "is not valid without a address" do
    expect(Appartment.new(rent: 1000)).not_to be_valid
  end

  it "is not valid without a rent" do
    expect(Appartment.new(address: 'Prague, Czechia')).not_to be_valid
  end

  it "has right owner" do
    expect(@appartment.owner?(@author)).to be(true)
  end

  it "has been removed by author" do
    expect { @appartment.destroy }.to change(Appartment, :count).by(-1)
  end
end