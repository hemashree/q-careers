require 'rails_helper'
require 'spec_helper'

feature 'Create candidates' do

  scenario 'should be ablr to see the form to enter the details' do
    visit '/employee/my_referrals'
    expect(page).to have_content('My Referrals')
    expect(page).to have_link('New Referral')
    click_link 'New Referral'
    fill_in "candidate[name]", with: "username"
    fill_in "candidate[email]", with: "user1@domain.com"
    fill_in "candidate[phone]", with: "123-456-7891"
    # fill_in "candidate[course]", with: "B.E"
    # fill_in "candidate[subject]", with: "CSE"
    # fill_in "candidate[institution]", with: "College"
    save_and_open_page
    click_button "Submit the Form"
    expect(page).to have_content('username')
    # expect(page).to have_content('B.E')
    # expect(page).to have_content('College')
  end
  
end