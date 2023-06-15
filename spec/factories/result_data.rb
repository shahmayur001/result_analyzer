FactoryBot.define do
  factory :result_data, class: ResultsData do
    subject { "Science" }
    timestamp { Date.today }
    marks { Faker::Number.decimal(l_digits: 3, r_digits: 2) }
  end
end
