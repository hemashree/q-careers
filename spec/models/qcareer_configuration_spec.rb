require 'rails_helper'
RSpec.describe QcareerConfiguration, type: :model do

describe "validate fields" do
  
  before :each do
    @career_configuration = QcareerConfiguration.new(
            :value => 'Value',
            :description => 'Desc'
        )
  end
  
  it "should validate the career configuation fields" do
   @career_configuration = QcareerConfiguration.new(
          :value => 'Value',
          :description => 'Desc'
      )
    expect(@career_configuration).to be_valid
  end

  it "should not validate the career configuation fields if any of the field is nill " do
    @career_configuration.value = nil
    expect(@career_configuration).not_to be_valid
    
    @career_configuration.description = nil
    expect(@career_configuration).not_to be_valid
  end
end



end