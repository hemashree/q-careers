FactoryGirl.define do
  sequence(:email) {|n| "candidate.#{n}@domain.com" }
  sequence :phone do |n|
    num = (10**9) + n
    num.to_s
  end
  
  factory :fresher_candidate, class: Candidate::Fresher do
    name "Fresher Candidate"
    year_of_passing {Date.today.year}
    experience_in_years 0

    email
    phone
    current_city "Current City"
    current_state "Current State"
    native_city "Native City"
    native_state "Native State"
    skills "C, C++, Java, HTML5, CSS3, Ruby, Rails"
    resume { Rack::Test::UploadedFile.new('test/fixtures/test.pdf', 'test.pdf') }
  end

  factory :experienced_candidate, class: Candidate::Experienced do
    name "Experienced Candidate"
    experience_in_years 7
    year_of_passing "2007"

    email
    phone
    current_city "Current City"
    current_state "Current State"
    native_city "Native City"
    native_state "Native State"
    skills "C, C++, Java, HTML5, CSS3, Ruby, Rails"
    resume { Rack::Test::UploadedFile.new('test/fixtures/test.pdf', 'test.pdf') }
  end
  
end