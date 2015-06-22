require 'rails_helper'
RSpec.describe CareerInterest, type: :model do

  # let(:career_interest) {FactoryGirl.create(:career_interest)}
   let(:candidate1) {FactoryGirl.create(:fresher_candidate, name: "Test user", email: "email1@domain.com", phone: "9523651245")}
   let(:candidate2) {FactoryGirl.create(:experienced_candidate, name: "Krishna Prasad", email: "email2@domain.com", phone: "9523651246")}
   let(:candidate3) {FactoryGirl.create(:experienced_candidate, name: "Anjankumar", email: "email3@domain.com", phone: "9523651247", current_city: "Mysore", native_city: "Mandya")}
   let(:event1) {FactoryGirl.create(:event, :name => "Event1", :venue => "Qwinix Mysore", :slug => "sjc")}
   let(:event2) {FactoryGirl.create(:event, :name => "Event2", :description => "Drive 2015", :slug => "vvc")}
   let(:event3) {FactoryGirl.create(:event, :name => "Event3", :slug => "vvk")}
   let(:career_interest1) {FactoryGirl.create(:employee_open_referral, candidate_id: candidate1.id, event_id: event1.id )}
   let(:career_interest2) {FactoryGirl.create(:employee_job_referral, candidate_id: candidate2.id, event_id: event2.id )}
   let(:career_interest3) {FactoryGirl.create(:registration_desk_entry, candidate_id: candidate3.id, event_id: event3.id, reported: true)}
   let(:user) {FactoryGirl.create(:user)}

  context "Factory" do
    it "should validate all the career_interest factories" do
      expect(FactoryGirl.build(:employee_open_referral).valid?).to be true
      expect(FactoryGirl.build(:employee_event_referral).valid?).to be true
      expect(FactoryGirl.build(:employee_job_referral).valid?).to be true
      expect(FactoryGirl.build(:online_job_application).valid?).to be true
      expect(FactoryGirl.build(:online_event_application).valid?).to be true
      expect(FactoryGirl.build(:registration_desk_entry).valid?).to be true
      expect(FactoryGirl.build(:sourced_from_job_portal_against_job).valid?).to be true
      expect(FactoryGirl.build(:sourced_from_job_portal).valid?).to be true
    end
  end

  context "Associations" do
    it { 
        should belong_to(:candidate)
        should belong_to(:event)
        should belong_to(:job)
        should belong_to(:referrer)
      }
  end

  context "Validations" do
    it { 
      should validate_presence_of :candidate
      should validate_presence_of :source
    }
  end

  context "Class Methods" do
    it "it fetches the career interests" do
      arr = [career_interest1, career_interest2, career_interest3]
      expect(CareerInterest.fetch(event1, candidate1)).to eq(career_interest1)
      expect(CareerInterest.fetch(event2, candidate2)).to eq(career_interest2)
      expect(CareerInterest.fetch(event3, candidate3)).to eq(career_interest3)
    end
  end

  context "Instance Methods" do
    it "should generate application code" do
      event10 = FactoryGirl.create(:event, :id => 1, :name => "Event10", :venue => "Qwinix Mysore", :slug => "sjce")
      candidate10 = FactoryGirl.create(:fresher_candidate, name: "Test user", email: "email1@domain.com", phone: "9523651245")
      career_interest10 = FactoryGirl.create(:employee_open_referral, :id => 1, :event_id => event10.id, :candidate_id => candidate10.id)
      expect(career_interest10.application_id).to eq("1-ER101")
    end

    it "the career interests can confirm, report or cancel report" do
      expect(career_interest1.confirm!).to eq(career_interest1.confirmed == true )
      expect(career_interest1.report!).to eq(career_interest1.reported == true )
      expect(career_interest3.cancel_report!).to eq(career_interest3.reported == false )
    end

    it "should display applicant name" do
      expect(career_interest1.applicant_name).to eq(candidate1.name)
    end

    it "should change referrer" do
      name = user.name
      career_interest1.change_referrer(user)
      expect(career_interest1.referrer.name).to eq(name)
    end
  end
end