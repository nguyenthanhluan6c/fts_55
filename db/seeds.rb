FactoryGirl.create :user, :admin
15.times do
  FactoryGirl.create :user, :normal
end
5.times do 
  FactoryGirl.create :category, :with_questions
end
