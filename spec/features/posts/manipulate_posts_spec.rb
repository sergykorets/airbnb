require 'rails_helper'

feature 'Creating a new post' do
  background do
    @author = FactoryGirl.create(:author)
    visit new_author_session_path
    fill_in 'email', with: @author.email
    fill_in 'password', with: @author.password
    click_button 'login'
  end

  scenario 'The new post form is filled in correctly' do
    visit new_authors_post_path

    find('#post_name').set('test title')
    find('#post_content').set('test content')
    
    expect { click_button 'Save blog post' }.to change { Post.count }.by(1)
    expect(current_path).to eq(authors_post_path(Post.last))

    visit authors_posts_path
    expect(page).to have_content('test title')
  end

  scenario 'The edit post form is filled in correctly' do
    post = FactoryGirl.create(:post, author: @author)
    visit edit_authors_post_path(post)

    find('#post_name').set('test title updated')
    find('#post_content').set('test content updated')
    click_button 'Save blog post'

    visit authors_posts_path
    expect(page).to have_content('test title updated')
  end

  scenario 'post remove' do
    post = FactoryGirl.create(:post, author: @author)
    visit authors_posts_path

    expect { click_link 'Remove' }.to change { Post.count }.by(-1)

    visit authors_posts_path
    expect(page).not_to have_content(post.name)
  end

  scenario 'post publish' do
    post = FactoryGirl.create(:post, author: @author)
    visit authors_posts_path

    click_link 'Publish'

    visit root_path
    expect(page).to have_content(post.name)
  end

  scenario 'post unpublish' do
    post = FactoryGirl.create(:post, author: @author)
    visit authors_posts_path
    click_link 'Publish'
    visit root_path
    expect(page).to have_content(post.name)

    visit authors_posts_path
    click_link 'Unpublish'
    visit root_path
    expect(page).not_to have_content(post.name)
  end
end
