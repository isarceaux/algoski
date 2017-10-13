# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20171013084324) do

  create_table "averages", force: :cascade do |t|
    t.date "start_date"
    t.float "average_value"
    t.integer "average_count"
    t.integer "number_of_guests"
    t.integer "resort_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["resort_id"], name: "index_averages_on_resort_id"
    t.index ["start_date"], name: "index_averages_on_start_date"
  end

# Could not dump table "classifieds" because of following StandardError
#   Unknown type 'jsonb' for column 'json_data'

  create_table "housings", force: :cascade do |t|
    t.string "title"
    t.integer "number_of_guests"
    t.string "link"
    t.boolean "accepts_home_away_payments"
    t.boolean "accepts_offline_payments"
    t.boolean "accepts_credit_cards"
    t.boolean "integrated_property_manager"
    t.boolean "multi_unit_property"
    t.boolean "online_bookable"
    t.boolean "instant_bookable"
    t.integer "number_of_bedrooms"
    t.integer "number_of_bathrooms_full"
    t.integer "number_of_bathrooms_half"
    t.integer "number_of_bathrooms_toilet_only"
    t.integer "number_of_bathrooms_full_and_half"
    t.integer "image_count"
    t.string "property_name"
    t.string "property_type"
    t.float "geocode_latitude"
    t.float "geocode_longitude"
    t.boolean "geocode_exact"
    t.float "average_rating"
    t.float "scaled_average_rating"
    t.integer "review_count"
    t.integer "min_stay_range_low"
    t.integer "min_stay_range_high"
    t.integer "resort_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["resort_id"], name: "index_housings_on_resort_id"
  end

  create_table "resorts", force: :cascade do |t|
    t.string "name"
    t.string "url"
    t.string "chain"
    t.string "department"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "region_number"
    t.string "ville"
    t.string "ville_url"
    t.boolean "ski_resort", default: false
    t.index ["region_number"], name: "index_resorts_on_region_number"
    t.index ["ski_resort"], name: "index_resorts_on_ski_resort"
    t.index ["ville"], name: "index_resorts_on_ville"
    t.index ["ville_url"], name: "index_resorts_on_ville_url"
  end

  create_table "subscriptions", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "resort_id"
    t.integer "user_id"
    t.index ["resort_id"], name: "index_subscriptions_on_resort_id"
    t.index ["user_id"], name: "index_subscriptions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "pro_account"
    t.string "last_name"
    t.string "first_name"
    t.string "civility"
    t.string "account"
    t.boolean "admin", default: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["first_name"], name: "index_users_on_first_name"
    t.index ["last_name"], name: "index_users_on_last_name"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
