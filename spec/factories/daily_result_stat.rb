FactoryBot.define do
  factory :daily_result_stat, class: DailyResultStat do
    subject { "Science" }
    date { Date.today }
    daily_low { Faker::Number.decimal(l_digits: 3, r_digits: 2) }
    daily_high { Faker::Number.decimal(l_digits: 3, r_digits: 2) }
    daily_volume { Faker::Number.number(digits: 2) }
  end
end
