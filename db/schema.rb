# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_06_09_105321) do
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

end
