FactoryGirl.define do
	sequence(:slug){ |n| "event-#{n}"}
  
  factory :planning_event do
  	name "Planning Event"
  	date {(Date.today + 3.month).to_s}
    status "planning"
    slug 
    venue "Qwinix Technologies, Mysore"
    description "Event Description"
  end

  factory :scheduled_event do
  	name "Scheduled Event"
  	date {(Date.today + 1.month).to_s}
  	status "scheduled"
  	slug 
    venue "Qwinix Technologies, Mysore"
    description "Event Description"
  end

  factory :past_event do
  	name "Past Event"
  	date {(Date.today - 3.month).to_s}
    status "over"
    slug 
    venue "Qwinix Technologies, Mysore"
    description "Event Description"
  end

end
