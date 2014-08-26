FactoryGirl.define do
  factory (:user) do
    name     { Forgery(:name).full_name }
    email    { Forgery(:internet).email_address }
    password { Forgery(:basic).password(at_least: 6) }

    trait :confirmed_user do
      after(:create) do |user|
        user.confirm!
      end
    end

    association :game_id, factory: :game
  end
end