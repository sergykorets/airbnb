require 'rails_helper'

feature 'Creating a new post' do
  background do
    @author = FactoryGirl.create(:author)
    @post = FactoryGirl.create(:post, author: @author, published: true)
    visit new_author_session_path
    fill_in 'email', with: @author.email
    fill_in 'password', with: @author.password
    click_button 'login'
  end

  scenario 'The new comment form is filled in correctly' do
    visit blog_post_path(@post)

    find('#body_input').set('test comment')

    expect { click_button 'Comment' }.to change { Comment.count }.by(1)
    expect(page).to have_content('test comment')
  end

  # scenario 'The edit post form is filled in correctly' do
  #   visit blog_post_path(@post)

  #   find('#body_input').set('test comment')
  #   click_button 'Comment'
  #   sleep 1

  #   expect { 
  #     accept_alert "You sure?" do
  #       find(:css, 'i.fa.fa-trash-o').click
  #     end
  #     sleep 1.second # !important
  #   }.to change(Comment, :count).by(-1)

  #   expect(page).to have_content('test title updated')

  #   expect { find(:css, 'i.fa.fa-trash-o').click }.to change { Comment.count }.by(-1)
  #   expect(page).to have_content('test title updated')
  # end
end
