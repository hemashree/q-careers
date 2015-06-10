require 'rails_helper'
require 'spec_helper'

feature 'Create candidates' do

  scenario 'should be ablr to see the form to enter the details' do
    visit '/employee/my_referrals'
    expect(page).to have_content('My Referrals')
    expect(page).to have_link('New Referral')
    click_link 'New Referral'
    fill_in "my_referral[name]", with: "username"
    fill_in "my_referral[email]", with: "user@domain.com"
    fill_in "my_referral[phone]", with: "1234567890"
    fill_in "my_referral[course]", with: "B.E"
    fill_in "my_referral[subject]", with: "CSE"
    fill_in "my_referral[institution]", with: "College"
    click_button "Submit the Form"
    expect(page).to have_content('username')
    expect(page).to have_content('B.E')
    expect(page).to have_content('College')
  end
  
end