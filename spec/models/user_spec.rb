require "rails_helper"

describe User do
  describe 'creation' do
    before(:each) do
      @attributes = FactoryGirl.attributes_for(:user)
    end

    it "should create a Member given valid attributes and joined a game" do
      expect { User.create!(@attributes)}.to_not raise_error
    end
  end
  describe 'validations' do
    before(:each) do
      @attributes = FactoryGirl.attributes_for(:creator)
    end

    it "should raise error for a missing name" do
      expect { User.create! @attributes.merge(name:"")}.to raise_error
    end

    it "should raise error for an empty or invalid email" do
      expect { User.create! @attributes.merge(email:"")}.to raise_error
    end
  end

  describe 'functionalities' do
    before(:each) do
      @manager = Creator.create! FactoryGirl.attributes_for(:creator)
      @game = Game.create! FactoryGirl.attributes_for(:game)
      @game.creator = @creator
      @member = User.create! FactoryGirl.attributes_for(:user)
    end

    it "should assign a member to a competition" do
      @member.game = @game
      expect(@member.game).to eq(@game)
    end
    it "should assign a newly joined member the competition's starter rank" do
      @member.game = @game
      @member.set_starter_rank
      expect(@member.rank).to eq("Starter")
    end
  end
end