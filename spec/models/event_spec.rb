require 'rails_helper'
RSpec.describe Event, type: :model do

  let(:event1) {FactoryGirl.create(:event, :name => "Event1", :venue => "Qwinix Mysore", :slug => "sjc")}
  let(:event2) {FactoryGirl.create(:event, :name => "Event2", :description => "Drive 2015", :slug => "vvc")}
  let(:event3) {FactoryGirl.create(:event, :name => "Event3", :slug => "vvk")}

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
  end


  context "Class Methods" do
    it "search" do
      arr = [event1, event2, event3]
      expect(Event.search("Qwinix Mysore")).to match_array([event1])
      expect(Event.search("Drive 2015")).to match_array([event2])
      expect(Event.search("Event3")).to match_array([event3])
    end

    it "it shows upcoming events" do
      event1 = FactoryGirl.create(:event, :name => "Event4", :slug => "up1", date: Date.tomorrow)
      event2 = FactoryGirl.create(:event, :name => "Event5", :slug => "up2", date: Date.tomorrow)
      event3 = FactoryGirl.create(:event, :name => "Event6", :slug => "up3", date: Date.tomorrow)
      arr = [event1, event2, event3]
     expect(Event.upcoming_events).to match_array(arr)
    end
  end

  context "Instance Methods" do
    it "it should display status" do
      event1 = FactoryGirl.build(:event, :name => "Event7", :slug => "up4", status: "scheduled")
      event2 = FactoryGirl.build(:event, :name => "Event8", :slug => "up5", status: "planning")
      event3 = FactoryGirl.build(:event, :name => "Event9", :slug => "up6", status: "over")
      expect(event1.display_status).to eq("Scheduled")
      expect(event2.display_status).to eq("Planning")
      expect(event3.display_status).to eq("Over")
    end

    it "it should test the event is over or planning or it is scheduled" do
      event1 = FactoryGirl.build(:event, :name => "Event10", :slug => "up7", status: "scheduled")
      event2 = FactoryGirl.build(:event, :name => "Event11", :slug => "up8", status: "planning")
      event3 = FactoryGirl.build(:event, :name => "Event12", :slug => "up9", status: "over")
      array = [event1, event2, event3]
      expect(event3.over?).to eq(event3.status == "over")
      expect(event1.scheduled?).to eq(event1.status == "scheduled")
      expect(event2.planning?).to eq(event2.status == "planning")
    end
  end
end