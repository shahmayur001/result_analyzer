# frozen_string_literal: true

When("I send a POST request to results_data_path with the following JSON:") do |request_body|
  @response = post '/results_data', result_data: JSON.parse(request_body), as: :json
end

Then("the response status should be {int}") do |expected_status|
  expect(@response.status).to eq(expected_status)
end

Given("there are the following result data for subject Science:") do |result_data|
  JSON.parse(result_data).each do |result|
    result["timestamp"] = Time.now.strftime("%Y-%m-%d %H:%M:%S")
    ResultsData.create(result)
  end
end

When("I calculate the Daily Result Stats for subject Science") do
  ResultData::CalculateDailyResultStatsJob.new.perform
end

Then("the following result stats should be calculated for them:") do |expected_data|
  expected_daily_stat = JSON.parse(expected_data)
  actual_daily_stat = DailyResultStat.last
  expect(actual_daily_stat["daily_low"]).to be_within(0.01).of(expected_daily_stat["daily_low"])
  expect(actual_daily_stat["daily_high"]).to be_within(0.01).of(expected_daily_stat["daily_high"])
  expect(actual_daily_stat["daily_volume"]).to be_within(0.01).of(expected_daily_stat["daily_volume"])
end

Given("there are the following daily result stats:") do |result_data|
  JSON.parse(result_data).each do |result|
    DailyResultStat.create(result)
  end
end

When("I calculate the monthly averages") do
  allow(Date).to receive(:today).and_return(Date.new(2022, 04, 18))
  ResultData::CalculateMonthlyAveragesJob.new.perform
end

Then("the following monthly average should be calculated for them:") do |expected_data|
  expected_daily_stat = JSON.parse(expected_data)
  actual_daily_stat = MonthlyAverage.last
  expect(actual_daily_stat["monthly_avg_low"]).to be_within(0.01).of(expected_daily_stat["monthly_avg_low"])
  expect(actual_daily_stat["monthly_avg_high"]).to be_within(0.01).of(expected_daily_stat["monthly_avg_high"])
  expect(actual_daily_stat["monthly_result_count_used"]).to be_within(0.01).of(expected_daily_stat["monthly_result_count_used"])
end
