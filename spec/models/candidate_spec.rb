require 'rails_helper'
RSpec.describe Candidate, :type => :model do

  let(:fresher_candidate) {FactoryGirl.create(:fresher_candidate)}
  let(:fresher_candidate1) {FactoryGirl.create(:fresher_candidate, name: "Test user", email: "email1@domain.com", phone: "9523651245")}
  let(:fresher_candidate2) {FactoryGirl.create(:fresher_candidate, name: "Krishna Prasad", email: "email2@domain.com", phone: "9523651246")}
  let(:fresher_candidate3) {FactoryGirl.create(:fresher_candidate, name: "Anjankumar", email: "email3@domain.com", phone: "9523651247")}

  context "Factory" do
    it "should validate all the candidate factories" do
      expect(FactoryGirl.build(:fresher_candidate).valid?).to be true
      expect(FactoryGirl.build(:experienced_candidate).valid?).to be true
    end
  end

  context "Associations" do
    it { 
      should have_many(:career_interests)
      should have_many(:events)
    }
  end

  context "Validations" do
    it { 
      should validate_presence_of :name
      should allow_value('Krishnaprasad Varma').for(:name)
      should_not allow_value('KP').for(:name)
      should_not allow_value("x"*257).for(:name)
    }

    it { 
      should validate_presence_of :email
      should allow_value('something@domain.com').for(:email)
      should_not allow_value('something domain.com').for(:email)
      should_not allow_value('something.domain.com').for(:email)
      should_not allow_value('ED').for(:email)
      should_not allow_value("x"*257+"@domain.com").for(:email)
    }  

    it { 
      should validate_presence_of :phone
      should allow_value('9880123123').for(:phone)
      should_not allow_value('9880-123-123').for(:phone)
      should_not allow_value('12343').for(:phone)
      should_not allow_value('1234 1234 1234 1234').for(:phone)
      should_not allow_value('ajsjdjajsj').for(:phone)
    }

    it { 
      should validate_presence_of :current_city
      should allow_value('Mysore').for(:current_city)
      should allow_value('New-Delhi').for(:current_city)
      should allow_value('New Delhi').for(:current_city)
      should_not allow_value('CC').for(:current_city)
      should_not allow_value("x"*129).for(:current_city)
    }

    it { 
      should validate_presence_of :native_city
      should allow_value('Mysore').for(:native_city)
      should allow_value('New-Delhi').for(:native_city)
      should allow_value('New Delhi').for(:native_city)
      should_not allow_value('CC').for(:native_city)
      should_not allow_value("x"*129).for(:native_city)
    }

    it { 
      should validate_presence_of :current_state
      should allow_value('Karnataka').for(:current_state)
      should allow_value('Tamil-Nadu').for(:current_state)
      should allow_value('Tamil Nadu').for(:current_state)
      should_not allow_value('TN').for(:current_state)
      should_not allow_value("x"*129).for(:current_state)
    }

    it { 
      should validate_presence_of :native_state
      should allow_value('Karnataka').for(:native_state)
      should allow_value('Tamil-Nadu').for(:native_state)
      should allow_value('Tamil Nadu').for(:native_state)
      should_not allow_value('TN').for(:native_state)
      should_not allow_value("x"*129).for(:native_state)
    }
  end

  context "Class Methods" do
    it "search" do
      arr = [fresher_candidate1, fresher_candidate2, fresher_candidate3]
      expect(Candidate.search("email1@domain.com")).to match_array([fresher_candidate1])
      expect(Candidate.search("Krishna Prasad")).to match_array([fresher_candidate2])
      expect(Candidate.search("Anjankumar")).to match_array([fresher_candidate3])
    end
  end

  context "Instance Methods" do
    it "namify" do
      candidate = FactoryGirl.build(:fresher_candidate, name: "Anjan Gowda")
      expect(candidate.namify).to eq("AG")

      candidate = FactoryGirl.build(:fresher_candidate, name: "Krishnaprasad")
      expect(candidate.namify).to eq("K")

      candidate = FactoryGirl.build(:fresher_candidate, name: "Mohandas Karam Chand Gandhi")
      expect(candidate.namify).to eq("MK")
    end

    it "display_current_address" do
      expect(FactoryGirl.build(:fresher_candidate, current_city: "Mysore", current_state: "Karnataka").display_current_address).to eq("Mysore, Karnataka")
      expect(FactoryGirl.build(:fresher_candidate, current_city: "Mysore", current_state: nil).display_current_address).to eq("Mysore")
      expect(FactoryGirl.build(:fresher_candidate, current_city: nil, current_state: "Karnataka").display_current_address).to eq("Karnataka")
    end

    it "display_native_address" do
      expect(FactoryGirl.build(:fresher_candidate, native_city: "Mysore", native_state: "Karnataka").display_native_address).to eq("Mysore, Karnataka")
      expect(FactoryGirl.build(:fresher_candidate, native_city: "Mysore", native_state: nil).display_native_address).to eq("Mysore")
      expect(FactoryGirl.build(:fresher_candidate, native_city: nil, native_state: "Karnataka").display_native_address).to eq("Karnataka")
    end
  end
end