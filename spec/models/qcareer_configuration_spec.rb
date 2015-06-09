require 'rails_helper'
RSpec.describe QcareerConfiguration, type: :model do

describe "validate fields" do
  
  before :each do
    @career_configuration = QcareerConfiguration.new(
            :value => 'Value',
            :description => 'Desc',
            :name => 'Dashboard'
        )
  end
  
  it "should validate the career configuation fields" do
    expect(@career_configuration).to be_valid
  end

  it "should not validate the career configuation fields if any of the field is nill " do
    @career_configuration.value = nil
    expect(@career_configuration).not_to be_valid
    
    @career_configuration.description = nil
    expect(@career_configuration).not_to be_valid
  end

  it "should not validate if the name is nill" do
    @career_configuration.name = nil
    expect(@career_configuration).not_to be_valid
  end
end



end