# spec/models/daily_result_stat_spec.rb
require 'rails_helper'

RSpec.describe DailyResultStat, type: :model do
  describe 'validations' do
    it 'allows the same subject on a different date' do
      today_stats = FactoryBot.create(:daily_result_stat)
      tomorrow_stats = FactoryBot.build(:daily_result_stat, date: Date.today.prev_month)
      expect(tomorrow_stats).to be_valid
    end

    it 'validates uniqueness of subject within date scope' do
      today_stats = FactoryBot.create(:daily_result_stat)
      tomorrow_stats = FactoryBot.build(:daily_result_stat)
      expect(tomorrow_stats).not_to be_valid
    end
  end
end
