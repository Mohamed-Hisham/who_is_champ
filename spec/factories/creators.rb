FactoryGirl.define do
  factory (:creator) do
    name     { Forgery(:name).full_name }
    email    { Forgery(:internet).email_address }
    password { Forgery(:basic).password(at_least: 6) }

    trait :confirmed_creator do
      after(:create) do |creator|
        creator.confirm!
      end
    end
  end
end