def create_guest
  FactoryGirl.attributes_for :creator
end

def create_creator(creator_hash = {})
  FactoryGirl.create :creator, :confirmed_creator, creator_hash
end

def create_user(user_hash = {})
  FactoryGirl.create :user, user_hash
end

def create_game(competition_hash = {})
  FactoryGirl.create :game, competition_hash
end

def create_rule(rule_hash = {})
  FactoryGirl.create :rule, rule_hash
end

def create_badges
  Badge.create!(name: :firstsignin, badge_type: :firstsignin)
  Badge.create!(name: :early, badge_type: :early)
  Badge.create!(name: :lastmonth, badge_type: :lastmonth)
  Badge.create!(name: :signinl1, badge_type: :signinl1)
  Badge.create!(name: :signinl2, badge_type: :signinl2)
  Badge.create!(name: :signinl3, badge_type: :signinl3)
end


def find_creator_by_email(email)
  Creator.find_by(email: email)
end