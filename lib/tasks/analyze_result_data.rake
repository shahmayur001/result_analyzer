namespace :analyze_result_data do
  desc 'Compute daily statistics for result data'
  task :compute_daily_stats_data => :environment do
    puts "Invoking Daily result stats job"
    ResultData::CalculateDailyResultStatsJob.perform_now
    Rake::Task["analyze_result_data:compute_monthly_average_data"].invoke if MonthlyAverage.is_third_wednesday_week_monday?
  end

  desc 'Compute montly average for result data'
  task :compute_monthly_average_data => :environment do
    puts "Invoking Monthly average job"
    ResultData::CalculateMonthlyAveragesJob.perform_now
  end
end

