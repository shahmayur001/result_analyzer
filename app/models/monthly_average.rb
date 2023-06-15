# frozen_string_literal: true

class MonthlyAverage < ApplicationRecord
  validates :subject, uniqueness: { scope: :date }

  # function used to find out whether current date is monday of 3rd week wednesday
  def self.is_third_wednesday_week_monday?
    start_day_of_month = Date.today.beginning_of_month
    third_wednesday_week_monday = (start_day_of_month + ((3 - start_day_of_month.wday + 7) % 7)) + 12
    third_wednesday_week_monday == Date.today
  end
end
