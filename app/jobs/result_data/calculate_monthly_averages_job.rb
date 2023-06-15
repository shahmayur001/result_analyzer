# frozen_string_literal: true

module ResultData
  class CalculateMonthlyAveragesJob < ApplicationJob
    queue_as :default
    MINIMUM_DAYS_VALUE = 5
    MINIMUM_RESULT_COUNT = 200

    def perform
      subject_list = DailyResultStat.distinct.pluck(:subject)
      subject_list.each do |subject|
        minimum_days_value = MINIMUM_DAYS_VALUE
        recent_data_average = DailyResultStat.calculate_average_for_subject_with_limit(subject, minimum_days_value)
        if recent_data_average["monthly_result_count_used"] >= MINIMUM_RESULT_COUNT
          create_monthly_average(subject, recent_data_average)
        else
          total_subject_data_present = DailyResultStat.where(subject: subject).count
          while(recent_data_average["monthly_result_count_used"] < MINIMUM_RESULT_COUNT && total_subject_data_present > minimum_days_value)
            minimum_days_value += 1
            recent_data_average = DailyResultStat.calculate_average_for_subject_with_limit(subject, minimum_days_value)
          end
          create_monthly_average(subject, recent_data_average)
        end
      end
    end

    private

    def create_monthly_average(subject, recent_data_average)
      MonthlyAverage.create(date: Date.today, subject: subject, monthly_avg_low: recent_data_average["monthly_avg_low"], monthly_avg_high: recent_data_average["monthly_avg_high"], monthly_result_count_used: recent_data_average["monthly_result_count_used"])
    end
  end
end
