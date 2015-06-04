FactoryGirl.define do
  factory :career_interest do
    confirmed false
    confirmed_at "10:35"
    referrer_id "1"
    source "registration_desk"
    reported false
    reported_at "08:00"
    status "applied"
    candidate
    event
  end
end