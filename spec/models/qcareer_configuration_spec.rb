require 'rails_helper'
RSpec.describe QcareerConfiguration, type: :model do
  context "Validations" do
    it { 
      should validate_presence_of :name
      should allow_value('HOMEPAGE').for(:name)
      # Should automatically upcase name before validation
      #should allow_value('homepage').for(:name)
      should allow_value('HOMEPAGE_EVENT').for(:name)
      should_not allow_value('HOMEPAGE EVENT').for(:name)
      should_not allow_value('XXXXXXX').for(:name)
      should_not allow_value("X"*33).for(:name)
    }
    it {
      should validate_presence_of :value
      should allow_value('HOMEPAGE_EVENT').for(:value)
      should_not allow_value('XX').for(:value)
      should_not allow_value("X"*257).for(:value)
    }
    it {
      should validate_presence_of :description
      should allow_value('Lorem Ipsum Comment').for(:description)
      should_not allow_value('XX').for(:description)
      should_not allow_value("X"*1025).for(:description)
    }
  end
end