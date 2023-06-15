# frozen_string_literal: true

module ResultData
  class CalculateDailyResultStatsJob < ApplicationJob
    queue_as :default

    def perform
      calculated_values = ResultsData.where(timestamp: Date.today.beginning_of_day..Date.today.end_of_day)
                          .group(:subject)
                          .select("subject, COUNT(*) AS daily_volume, MIN(marks) AS daily_low, MAX(marks) AS daily_high, timestamp AS date")

      # To avoid adding duplicate data in model insert_all query is not used as it skips the validation
      # DailyResultStat.insert_all(calculated_values)
      calculated_values.each do |calculated_value|
        DailyResultStat.create(calculated_value.attributes)
      end
    end
  end
end
