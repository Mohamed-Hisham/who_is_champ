require "rails_helper"

describe Creator do
  describe 'creation' do
    before(:each) do
      @attributes = FactoryGirl.attributes_for(:creator)
    end

    it "should create a competition manager given valid attributes" do
      expect { Creator.create!(@attributes)}.to_not raise_error
    end
  end
  describe 'validations' do
    before(:each) do
      @attributes = FactoryGirl.attributes_for(:creator)
    end

    it "should raise error for a missing manager's name" do
      expect { Creator.create! @attributes.merge(name:"")}.to raise_error
    end

    it "should raise error for an empty or invalid manager's email" do
      expect { Creator.create! @attributes.merge(email:"")}.to raise_error
    end
  end
end