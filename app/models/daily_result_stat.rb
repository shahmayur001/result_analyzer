# frozen_string_literal: true

class DailyResultStat < ApplicationRecord
  validates :subject, uniqueness: { scope: :date }
  scope :filter_by_subject, ->(subject) { where(subject: subject) }
  scope :order_by_date, -> { order(date: :desc) }
  
  def self.calculate_average_for_subject_with_limit(subject, fetch_count)
    recent_data_ids = filter_by_subject(subject).order_by_date.first(fetch_count).pluck(:id)
    aggregated_daily_stats = where(id: recent_data_ids).select("SUM(daily_volume) AS monthly_result_count_used, AVG(daily_low) AS monthly_avg_low, AVG(daily_high) AS monthly_avg_high").first
  end
end
