FactoryGirl.define do
  factory :category do
    sequence(:name) { |n| "Fakecategory#{n}" }
  end
end
