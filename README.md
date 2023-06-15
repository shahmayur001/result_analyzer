## README
## System Dependencies
- Ruby 3.1.2

## Development Setup
1. Git clone this repository
     - git clone <repo-url>
2. `bundle install`
3. `rails db:create` 
4. `rails db:migrate`
5. `rails db:seed`
6. `rails server`

## Running Tests
`bundle exec rspec` to run rspec test cases
`bundle exec cucumber` to run cucumber test cases

## Database
- sqlite

## Schema
  create_table "daily_result_stats", force: :cascade do |t|
    t.date "date"
    t.string "subject"
    t.decimal "daily_low"
    t.decimal "daily_high"
    t.integer "daily_volume"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "monthly_averages", force: :cascade do |t|
    t.date "date"
    t.string "subject"
    t.decimal "monthly_avg_low"
    t.decimal "monthly_avg_high"
    t.integer "monthly_result_count_used"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "results_data", force: :cascade do |t|
    t.string "subject"
    t.datetime "timestamp"
    t.decimal "marks"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

## Project flow
- User can hit our endpoint at POST "/results_data" to store their data.
  curl --location 'http://localhost:3000/results_data' \
  --header 'Content-Type: application/json' \
  --data '{
  "result_data": {"subject": "Science", "timestamp": "2022-06-11 12:01:34.678", "marks": 99.25}
  }'

# RELEASE NOTES
## Introduction
This application can be used to store the user test results.Every day at 6PM, our app will aggregate all the collected results for a day and calculates "Daily Result Stats" and if current date is Monday of third week of Wednessday then it calculates "Monthly Result Averages" too.

## To calculate Daily Result Stats
- For a given day, all the result data will be taken for a subject and daily stats will be calculated.
- In the daily statistics calculation daily_low, daily_high and daily_volume will be calculated for the subject   and data will be stored in the DailyResultStat model.

## To calculate Monthly Averages
- On a Monday of week of third Wednessday the Monthly Averages is calculated.
- To calculate Monthly averages it will take atleast 5 days of Daily Result Stats data for a subject.If result count of these 5 days is less than 200, it will keep on adding data more until the minimum aggregated result count of 200 is reached.
- Average of daily_high and daily_low along with the result_count is calculated and data is stored in MonthlyAverage table.

# Additional Features
## Test Cases
- Added Rspec test cases 
 Reference: https://github.com/rspec/rspec-rails
- Added cucumber test cases
 Reference: https://cucumber.io/docs/tools/ruby/
## Validation
- Added validation to verify the data presence and uniqueness
## Scheduler
- Added whenever gem to schedule rake task at 6:00 PM everyday
## Rake task
- Added rask task to initiate data computation process
## Active Job
- Added active job to calculate daily stats and Monthly averages

## Future Enhancements
- Sidekiq can be used as an active jobs adapter
- UI can be created to show daily stats and monthly average reports
- Different DB(postgresql, mysql) can be used for scaling

## Coverage report

![Coverage Report](/public/images/coverage.png)
