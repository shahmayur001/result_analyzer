require 'rails_helper'

RSpec.describe MonthlyAverage, type: :model do
  describe 'validations' do
    it 'allows the same subject on a different date' do
      june_monthly_average = FactoryBot.create(:monthly_average)
      july_monthly_average = FactoryBot.build(:monthly_average, date: "Tue, 17 July 2023")
      expect(july_monthly_average).to be_valid
    end

    it 'validates uniqueness of subject within date scope' do
      june_monthly_average = FactoryBot.create(:monthly_average)
      duplicate_june_monthly_average = FactoryBot.build(:monthly_average)
      expect(duplicate_june_monthly_average).not_to be_valid
    end
  end

  describe 'is_third_wednesday_week_monday method' do
    it 'should return true if current date is monday of 3rd wednesday week' do
      third_monday_date = Date.new(2023, 6, 19)
      allow(Date).to receive(:today).and_return(third_monday_date)
      expect(MonthlyAverage.is_third_wednesday_week_monday?).to be_truthy
    end

    it 'should return false if current date is monday of 3rd wednesday week' do
      third_monday_date = Date.new(2023, 6, 18)
      allow(Date).to receive(:today).and_return(third_monday_date)
      expect(MonthlyAverage.is_third_wednesday_week_monday?).to be_falsy
    end
  end
end
