FactoryGirl.define do
  factory :question_option do
    question
    content {Faker::Lorem.paragraphs rand(1..5)}
    is_correct true
  end
end
