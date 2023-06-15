# frozen_string_literal: true

set :bundle_command, "/home/triodec/.rbenv/shims/bundle exec"
set :output, File.expand_path("#{__dir__}/../log/cron.log")

every 1.day, at: '06:00 PM' do
  rake "analyze_result_data:compute_daily_stats_data"
end
