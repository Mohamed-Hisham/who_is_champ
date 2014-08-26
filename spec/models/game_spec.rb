require "rails_helper"

describe Game do
  describe 'creation' do
    before(:each) do
      @attributes = FactoryGirl.attributes_for(:game)
    end

    it "should create a competition given valid attributes and competition manager" do
      expect { Game.create!(@attributes)}.to_not raise_error
    end
  end

  describe 'validations' do
    before(:each) do
      @attributes = FactoryGirl.attributes_for(:game)
    end

    it "should raise an error for a missing competition name" do
      expect { Game.create! @attributes.merge(name:"")}.to raise_error
    end

    it "should raise an error for a missing competition description" do
      expect { Game.create! @attributes.merge(description:"")}.to raise_error
    end

    it "should raise an error for a missing number of points per rule" do
      expect { Game.create! @attributes.merge(pts_per_rule:"")}.to raise_error
    end

    it "should raise an error for a missing expert rank for a competition" do
      expect { Game.create! @attributes.merge(expert_rank:"")}.to raise_error
    end

    it "should raise an error for a missing normal_rank for a competition" do
      expect { Game.create! @attributes.merge(normal_rank:"")}.to raise_error
    end

    it "should raise an error for a missing starter_rank for a competition" do
      expect { Game.create! @attributes.merge(starter_rank:"")}.to raise_error
    end

    it "should raise an error for number of points less than 100" do
      expect { Game.create! @attributes.merge(pts_per_rule:"")}.to raise_error
    end

    it "should raise an error for number of points more than 1000" do
      expect { Game.create! @attributes.merge(pts_per_rule:"")}.to raise_error
    end
  end
end