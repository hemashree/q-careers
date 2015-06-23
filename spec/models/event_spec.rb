require 'rails_helper'
RSpec.describe Event, type: :model do

  let(:qwinix_careers) {FactoryGirl.create(:qwinix_careers, :name => "Qwinix Careers", slug: "qwinix-careers")}
  let(:apple) {FactoryGirl.create(:planning_event, name: "Apple", venue: "Jammu", description: "Fruit - Apple a day keeps doctor away", slug: "sebu")}
  let(:mango) {FactoryGirl.create(:scheduled_event, name: "Mango", venue: "Karataka", description: "Fruit - King of fruits", slug: "maavu")}
  let(:orange) {FactoryGirl.create(:past_event, name: "Orange", venue: "Nagpur", description: "Fruit - Orange for healthy life", slug: "kithale")}

  context "Factory" do
    it "should validate all the event factories" do
      expect(FactoryGirl.build(:planning_event).valid?).to be true
      expect(FactoryGirl.build(:scheduled_event).valid?).to be true
      expect(FactoryGirl.build(:past_event).valid?).to be true
    end
  end

  context "Associations" do
    it { should have_many(:career_interests) }
    it { should have_many(:candidates) }
  end

  context "Validations" do
    it { 
      should validate_presence_of :name
      should allow_value('Recruitment Drive 2015').for(:name)
    }

    it { 
      should validate_presence_of :slug
      should allow_value('walk-in').for(:slug)
    }

    it { 
      should validate_presence_of :date
      should allow_value('2015-02-14').for(:date)
    }

    it { 
      should validate_presence_of :status
      should allow_value('planning').for(:status)
      should allow_value('scheduled').for(:status)
      should allow_value('over').for(:status)
      should_not allow_value('status').for(:status)
    }
    
    it { 
      should validate_presence_of :venue
      should allow_value('Qwinix Technologies, Mysore').for(:venue)
      should_not allow_value('Mysore$%?').for(:venue)
    }

    it { should_not allow_value("x"*2057).for(:description) }
  
    it { 
      should validate_presence_of :status
      should allow_value('planning').for(:status)
      should allow_value('scheduled').for(:status)
      should allow_value('over').for(:status)
      should_not allow_value('status').for(:status)
    }
    
    it { 
      should validate_presence_of :venue
      should allow_value('Qwinix Technologies, Mysore').for(:venue)
      should_not allow_value('Mysore$%?').for(:venue)
    }
  end

  context "Class Methods" do
    it "search" do
      arr = [event1, event2, event3]
      
      # Search Name
      expect(Event.search("Apple")).to match_array([apple])
      expect(Event.search("Mango")).to match_array([mango])
      expect(Event.search("Orange")).to match_array([orange])

      # Search Venue
      expect(Event.search("Jammu")).to match_array([apple])
      expect(Event.search("Karataka")).to match_array([mango])
      expect(Event.search("Nagpur")).to match_array([orange])

      # Search Description
      expect(Event.search("doctor")).to match_array([apple])
      expect(Event.search("King")).to match_array([mango])
      expect(Event.search("healthy")).to match_array([orange])

      expect(Event.search("Fruit")).to match_array(arr)

      # Search Slug
      expect(Event.search("sebu")).to match_array([apple])
      expect(Event.search("maavu")).to match_array([mango])
      expect(Event.search("kithale")).to match_array([orange])

      # Negative Case
      expect(Event.search("Hello World")).to match_array([])
    end

    it "it shows upcoming events" do
      arr = [qwinix_careers, apple, mango, orange]
      expect(Event.upcoming_events).to match_array([mango, orange])
    end
  end

  context "Instance Methods" do
    it "it should display status" do
      expect(apple.display_status).to eq("Planning")
      expect(mango.display_status).to eq("Scheduled")
      expect(orange.display_status).to eq("Over")
    end

    it "it should test the event is over or planning or it is scheduled" do
      array = [event1, event2, event3]
      expect(apple.planning?).to be_true
      expect(mango.scheduled?).to be_true
      expect(orange.over?).to be_true
    end
  end
end