require 'rails_helper'
RSpec.describe Candidate, :type => :model do

  let(:candidate) {FactoryGirl.create(:candidate)}
  let(:candidate1) {FactoryGirl.create(:candidate, name: "Test user", email: "email1@domain.com", phone: "952-365-1245")}
  let(:candidate2) {FactoryGirl.create(:candidate, name: "Krishna Prasad", email: "email2@domain.com", phone: "952-365-1246")}
  let(:candidate3) {FactoryGirl.create(:candidate, name: "Anjankumar", email: "email3@domain.com", phone: "952-365-1247")}

  context "Factory" do
    it "should validate all the candidate factories" do
      expect(FactoryGirl.build(:candidate).valid?).to be true
    end
  end

  context "Associations" do
    it { should have_many(:career_interests) }
    it { should have_many(:events) }
  end

  context "Validations" do
    it { should validate_presence_of :name }
    it { should allow_value('Krishnaprasad Varma').for(:name )}
    it { should_not allow_value('KP').for(:name )}
    it { should_not allow_value("x"*257).for(:name )}

    it { should validate_presence_of :email }
    it { should allow_value('something@domain.com').for(:email )}
    it { should_not allow_value('something domain.com').for(:email )}
    it { should_not allow_value('something.domain.com').for(:email )}
    it { should_not allow_value('ED').for(:email )}
    it { should_not allow_value("x"*257+"@domain.com").for(:email )}

    it { should validate_presence_of :phone }
    it { should allow_value('988-012-3123').for(:phone )}
    it { should_not allow_value('12343').for(:phone )}
    it { should_not allow_value('1234 1234 1234 1234').for(:phone )}

    it { should validate_presence_of :current_city }
    it { should allow_value('Mysore').for(:current_city )}
    it { should allow_value('New-Delhi').for(:current_city )}
    it { should allow_value('New Delhi').for(:current_city )}
    it { should_not allow_value('CC').for(:current_city )}
    it { should_not allow_value("x"*129).for(:current_city )}

    it { should validate_presence_of :native_city }
    it { should allow_value('Mysore').for(:native_city )}
    it { should allow_value('New-Delhi').for(:native_city )}
    it { should allow_value('New Delhi').for(:native_city )}
    it { should_not allow_value('CC').for(:native_city )}
    it { should_not allow_value("x"*129).for(:native_city )}
  end

  context "Class Methods" do
    it "search" do
      arr = [candidate1, candidate2, candidate3]
      expect(Candidate.search("email1@domain.com")).to match_array([candidate1])
      expect(Candidate.search("Krishna Prasad")).to match_array([candidate2])
      expect(Candidate.search("Anjankumar")).to match_array([candidate3])
    end
  end

  context "Instance Methods" do
    it "namify" do
      candidate = FactoryGirl.build(:candidate, name: "Anjan Gowda")
      expect(candidate.namify).to eq("AG")

      candidate = FactoryGirl.build(:candidate, name: "Krishnaprasad")
      expect(candidate.namify).to eq("K")

      candidate = FactoryGirl.build(:candidate, name: "Mohandas Karam Chand Gandhi")
      expect(candidate.namify).to eq("MK")
    end

    it "display_current_address" do
      expect(FactoryGirl.build(:candidate, current_city: "Mysore", current_state: "Karnataka").display_current_address).to eq("Mysore, Karnataka")
      expect(FactoryGirl.build(:candidate, current_city: "Mysore", current_state: nil).display_current_address).to eq("Mysore")
      expect(FactoryGirl.build(:candidate, current_city: nil, current_state: "Karnataka").display_current_address).to eq("Karnataka")
    end

    it "display_native_address" do
      expect(FactoryGirl.build(:candidate, native_city: "Mysore", native_state: "Karnataka").display_native_address).to eq("Mysore, Karnataka")
      expect(FactoryGirl.build(:candidate, native_city: "Mysore", native_state: nil).display_native_address).to eq("Mysore")
      expect(FactoryGirl.build(:candidate, native_city: nil, native_state: "Karnataka").display_native_address).to eq("Karnataka")
    end
  end
end