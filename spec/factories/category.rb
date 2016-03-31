FactoryGirl.define do
  factory :category do
    name {Faker::Name.name}
    description {Faker::Lorem.paragraphs rand(5..15)}
    number_of_questions_in_examination {rand 10..30}
    time_limit {rand 30..60}

    trait :with_questions do
      ignore do
        number_of_questions 10
      end
      after(:build) do |category, evaluator|
        create_list :question_with_question_options, evaluator.number_of_questions, category: category
      end
    end
  end
end
