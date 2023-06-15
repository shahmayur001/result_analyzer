require 'rails_helper'

RSpec.describe ResultsData, type: :model do
  describe 'validations' do
    it 'validates presence of subject, timestamp, and marks' do
      result_data = FactoryBot.build(:result_data)
      expect(result_data).to be_valid
    end

    it 'should not validates if subject, timestamp or marks are empty' do
      result_data = FactoryBot.build(:result_data, timestamp: nil)
      expect(result_data).not_to be_valid
    end
  end
end
