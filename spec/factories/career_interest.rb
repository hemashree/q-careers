FactoryGirl.define do
  # t.integer  "candidate_id"
  # t.integer  "event_id"
  # t.boolean  "confirmed"
  # t.datetime "confirmed_at"
  # t.datetime "created_at",                                             null: false
  # t.datetime "updated_at",                                             null: false
  # t.integer  "referrer_id"
  # t.string   "source",       limit: 128, default: "registration_desk"
  # t.boolean  "reported",                 default: false
  # t.datetime "reported_at"
  # t.string   "status"

  # factory :career_interest do
  #   confirmed false
  #   confirmed_at "10:35"
  #   referrer_id "1"
  #   source "registration_desk"
  #   reported false
  #   reported_at "08:00"
  #   status "applied"
  #   candidate
  #   event
  # end
    
  # An employee refer a candidate against no job or event
  factory :employee_open_referral, class: CareerInterest do
    association :candidate, :factory => :fresher_candidate
    association :referrer, :factory => :user
    source "employee_referral"
  end

  # An employee refer a candidate against an event
  factory :employee_event_referral, class: CareerInterest do
    association :candidate, :factory => :fresher_candidate
    association :referrer, :factory => :user
    event
    source "employee_referral"
  end

  # An employee refer a candidate against a job
  factory :employee_job_referral, class: CareerInterest do
    association :candidate, :factory => :fresher_candidate
    association :referrer, :factory => :user
    job
    source "employee_referral"
  end

  # A Candidate apply online for a job
  factory :online_job_application, class: CareerInterest do
    association :candidate, :factory => :fresher_candidate
    job
    source "online_application"
  end

  # A Candidate apply online for an event
  factory :online_event_application, class: CareerInterest do
    association :candidate, :factory => :fresher_candidate
    event
    source "online_application"
  end

  # A Candidate walkin for an event without registering online
  # And Registration Desk creates an entry for him
  factory :registration_desk_entry, class: CareerInterest do
    association :candidate, :factory => :fresher_candidate
    event
    source "registration_desk"
  end

  # A Recruiter source a candidate from a job portal against a job
  factory :sourced_from_job_portal_against_job, class: CareerInterest do
    association :candidate, :factory => :fresher_candidate
    job
    source "sourced_from_job_portal"
  end

  # A Recruiter source a candidate from a job portal but not against any job
  factory :sourced_from_job_portal, class: CareerInterest do
    association :candidate, :factory => :fresher_candidate
    source "sourced_from_job_portal"
  end

end