FactoryGirl.define do
	sequence(:q_auth_uid) { |n| "#{n}" }
	sequence(:username) { |n| "anjankumarhn#{n}" }

	factory :user, :class =>"QAuthRubyClient::User" do
		name "Anjan Gowda"
		username 
		email 
		biography "ROR Developer"
		phone "9741393543"
		skype "anjankumarhn"
		linkedin "anjankumarhn"
		city "Mysore"
		state "Karnataka"
		country "India"
		department "development"
		designation "developer"
		thumb_url "http://users/thumb_url"
		medium_url "http://users/medium_url"
		large_url "http://users/large_url"
		original_url "http://users/original_url"
		user_type "super_admin"
		q_auth_uid 
		q_careers_role "q_careers_admin"
		auth_token {SecureRandom.hex}
		token_created_at Time.now
  end
end