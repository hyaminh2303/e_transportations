FactoryBot.define do
  factory :e_transportation do
    association :owner, factory: :owner
  end
end
