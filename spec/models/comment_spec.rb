require 'rails_helper'

RSpec.describe Comment, type: :model do
  before(:each) do
    @author = FactoryGirl.create(:author)
    @comment = FactoryGirl.create(:comment, author: @author)
  end

  it "is valid with valid attributes" do
    expect(@comment).to be_valid
  end

  it "is not valid without a author" do
    expect(Comment.new(content: Faker::Lorem.paragraph)).not_to be_valid
  end

  it "is not valid without a content" do
    expect(Comment.new(author: @author)).not_to be_valid
  end

  it "has right owner" do
    expect(@comment.owner?(@author)).to be(true)
  end

  it "has been commented on post" do
    expect(FactoryGirl.create(:post_comment)).to have_attributes(commentable_type: "Post")
  end

  it "has been commented on category" do
    expect(FactoryGirl.create(:tag_comment)).to have_attributes(commentable_type: "Tag")
  end
  
  it "has been removed by author" do
    expect { @comment.destroy }.to change(Comment, :count).by(-1)
  end
end