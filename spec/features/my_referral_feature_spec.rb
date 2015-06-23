require 'rails_helper'
require 'spec_helper'

feature 'Create candidates' do
  scenario "User can able to see the myreferral page" do
    page.visit "/employee/my_referrals"
    expect(page).to have_link('New Referral')
     expect(page).to have_content("My Referrals")
  end
end