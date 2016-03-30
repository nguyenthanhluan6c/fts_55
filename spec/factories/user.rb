FactoryGirl.define do
  sequence(:email) {|n| "example#{n}@gmail.com"}
  factory :user do
    name {Faker::Name.name}
    email
    password "111111"
    role "normal"

    trait :normal do
      role "normal"
    end
    trait :mod do
      role "mod"
    end
    trait :admin do
      name "Kratos"
      email "nguyenthanhluan@gmail.com"
      password "111111"
      password_confirmation "111111"
      role "admin"
    end
  end
end
