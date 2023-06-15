# spec/workers/calculate_daily_result_stats_job_spec.rb
require 'rails_helper'

RSpec.describe ResultData::CalculateDailyResultStatsJob, type: :job do

  let(:data) { FactoryBot.create_list(:result_data, 20) }
  let(:job) { ResultData::CalculateDailyResultStatsJob.new }
  
  describe 'perform' do
    it 'Should successfully add data in DailyResultStat model' do
      data
      job.perform
      expect(DailyResultStat.count).to eq(1)
    end
  end
end
