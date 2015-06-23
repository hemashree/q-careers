FactoryGirl.define do
	sequence(:slug){ |n| "walk-in#{n}"}
  	factory :event do
    name "Recruitment Drive (March 2015)"
    date "2015-02-14"
    slug 
    venue "Qwinix Technologies, Mysore"
    description "My String"
    status "scheduled"
  end
end
