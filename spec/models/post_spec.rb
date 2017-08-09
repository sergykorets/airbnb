require 'rails_helper'

RSpec.describe Post, type: :model do
  before(:each) do
    @author = FactoryGirl.create(:author)
    @post = FactoryGirl.create(:post, author: @author)
  end

  it "is valid with valid attributes" do
    expect(@post).to be_valid
  end

  it "is not valid without a name" do
    expect(Post.new(content: Faker::Lorem.paragraph)).not_to be_valid
  end

  it "is not valid without a content" do
    expect(Post.new(name: Faker::Lorem.paragraph)).not_to be_valid
  end

  it "has right owner" do
    expect(@post.owner?(@author)).to be(true)
  end

  it "has been removed by author" do
    expect { @post.destroy }.to change(Post, :count).by(-1)
  end
end