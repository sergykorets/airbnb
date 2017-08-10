require 'rails_helper'

feature 'Creating a new appartment' do
  background do
    @author = FactoryGirl.create(:author)
    visit new_author_session_path
    fill_in 'email', with: @author.email
    fill_in 'password', with: @author.password
    click_button 'login'
  end

  scenario 'The new appartment form is filled in correctly' do
    visit new_appartment_path

    find('#geocomplete').set('Prague, Czechia')
    find('#appartment_rent').set(1000)
    
    expect { click_button 'Save' }.to change { Appartment.count }.by(1)
    expect(current_path).to eq(appartments_path)

    visit appartments_path
    expect(page).to have_content('Prague, Czechia')
  end

  scenario 'The edit appartment form is filled in correctly' do
    appartment = FactoryGirl.create(:appartment, author: @author)
    visit edit_appartment_path(appartment)

    find('#geocomplete').set('Berlin, Germany')
    find('#appartment_rent').set(2000)
    click_button 'Save'

    visit appartments_path
    expect(page).to have_content('Berlin, Germany')
  end
end
