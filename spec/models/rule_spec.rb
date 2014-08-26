require "rails_helper"

describe Rule do
  describe 'creation' do
    before(:each) do
      @attributes = FactoryGirl.attributes_for(:rule)
    end

    it "should create a rule with valid attributes" do
      @rule = Rule.create!(@attributes)
      expect { @rule }.to_not raise_error
    end
  end

  describe 'validations' do
    before(:each) do
      @attributes = FactoryGirl.attributes_for(:rule)
    end

    it "should raise an error for a missing rule description" do
      expect { Rule.create! @attributes.merge(description:"")}.to raise_error
    end

    it "should raise an error for an invalid rule priority" do
      expect { Rule.create! @attributes.merge(priority:"N/A")}.to raise_error(ArgumentError,"'N/A' is not a valid priority")
    end
  end
end