require 'rails_helper'

RSpec.describe ResultData::CalculateMonthlyAveragesJob, type: :job do

  let(:daily_result_of_science) do
    FactoryBot.build_list(:daily_result_stat, 5, subject: "Science").each_with_index do |value, index|
      value.date = Date.today - index
      value.save
    end
  end
  let(:daily_result_of_maths) do 
    FactoryBot.build_list(:daily_result_stat, 5, subject: "Maths").each_with_index do |value, index|
      value.date = Date.today - index
      value.save
    end
  end
  let(:job) { ResultData::CalculateMonthlyAveragesJob.new }
  
  describe 'perform' do

    before do
      daily_result_of_science
    end

    it 'Should successfully add data in MonthlyAverage' do
      job.perform
      expect(MonthlyAverage.count).to eq(1)
    end

    it 'Should calculate average of all subjects whose daily stats are present' do
      daily_result_of_maths
      job.perform
      expect(MonthlyAverage.count).to eq(2)
    end
  end
end
