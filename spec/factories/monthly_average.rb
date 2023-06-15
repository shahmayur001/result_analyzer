FactoryBot.define do
  factory :monthly_average, class: MonthlyAverage do
    subject { "Science" }
    date { "Tue, 19 Jun 2023" }
    monthly_avg_low { Faker::Number.decimal(l_digits: 3, r_digits: 2) }
    monthly_avg_high { Faker::Number.decimal(l_digits: 3, r_digits: 2) }
    monthly_result_count_used { Faker::Number.number(digits: 2) }
  end
end
