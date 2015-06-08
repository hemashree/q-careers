FactoryGirl.define do
  sequence(:email) {|n| "candidate.#{n}@domain.com" }
  factory :candidate do
    name "Anjan Kumar"
    email
    phone "910-121-4242"
    current_city "Mysore"
    current_state "Karnataka"
    native_city "Mandya"
    native_state "Karnataka"
    year_of_passing "2014"
    experience_in_years "2"
    skills "C, C++, Java, HTML5, CSS3, Ruby, Rails"
    resume { Rack::Test::UploadedFile.new('test/fixtures/test.pdf', 'test.pdf') }
  end
end