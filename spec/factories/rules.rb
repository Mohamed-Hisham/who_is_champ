FactoryGirl.define do
  factory (:rule) do
    description { Forgery(:lorem_ipsum).words(20) }
    priority    {Rule.priorities[:high]}

    association :game_id, factory: :game
  end
end