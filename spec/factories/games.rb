FactoryGirl.define do
  factory (:game) do
    name          { Forgery(:name).name }
    description   { Forgery(:lorem_ipsum).words(20) }
    pts_per_rule  { Forgery(:basic).number(at_least: 100,
                                          at_most:1000) }
    expert_rank   { "Expert" }
    normal_rank   { "Normal" }
    starter_rank  { "Starter"}

    association :creator_id, factory: :creator
  end
end