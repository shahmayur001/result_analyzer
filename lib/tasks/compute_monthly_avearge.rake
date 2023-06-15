namespace : do
  desc 'Compute daily statistics and montly average for result data'
  task :invoke_daily_stats_job => :environment do
    puts "Invoking jobs to calculate daily stat and monthly stat data"
    ResultData::CalculateDailyResultStatsJob.perform_now
    ResultData::CalculateMonthlyAveragesJob.perform_now if MonthlyAverage.is_third_wednesday_week_monday? # create rake task here
  end
end