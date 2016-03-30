FactoryGirl.define do
  factory :question do
    category
    content {Faker::Lorem.paragraphs rand(1..5)}
    option_type {["multi_choice"].sample}
    factory :question_with_question_options do
      ignore do
        number_of_options 4
      end
      after(:build) do |question, evaluator|
        question.question_options << build_list(:question_option, evaluator.number_of_options, question: question)
      end
    end
    end
end
