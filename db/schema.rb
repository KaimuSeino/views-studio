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

ActiveRecord::Schema[7.2].define(version: 2025_07_07_130633) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "analytics", force: :cascade do |t|
    t.string "content_type", null: false
    t.bigint "content_id", null: false
    t.integer "revenue", default: 0
    t.integer "conversions", default: 0
    t.integer "lead_views", default: 0
    t.integer "lead_conversions", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["content_type", "content_id"], name: "index_analytics_on_content"
    t.index ["content_type", "content_id"], name: "index_analytics_on_content_type_and_content_id", unique: true
  end

  create_table "episodes", force: :cascade do |t|
    t.bigint "work_id", null: false
    t.string "title", null: false
    t.integer "episode_number"
    t.string "content_type", default: "video"
    t.string "cloudinary_url"
    t.string "thumbnail_url"
    t.text "description"
    t.boolean "is_paid", default: false
    t.integer "price", default: 0
    t.string "duration", default: "00:00:00"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cloudinary_url"], name: "index_episodes_on_cloudinary_url"
    t.index ["work_id", "episode_number"], name: "index_episodes_on_work_id_and_episode_number"
    t.index ["work_id"], name: "index_episodes_on_work_id"
  end

  create_table "short_clips", force: :cascade do |t|
    t.string "title", null: false
    t.string "episode_title"
    t.text "description"
    t.string "cloudinary_url", null: false
    t.string "cloudinary_public_id"
    t.string "content_type", null: false
    t.string "visibility", default: "public"
    t.integer "duration", default: 0
    t.bigint "work_id"
    t.string "tags", default: [], array: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cloudinary_public_id"], name: "index_short_clips_on_cloudinary_public_id"
    t.index ["cloudinary_url"], name: "index_short_clips_on_cloudinary_url"
    t.index ["visibility"], name: "index_short_clips_on_visibility"
    t.index ["work_id"], name: "index_short_clips_on_work_id"
  end

  create_table "views", force: :cascade do |t|
    t.bigint "analytic_id", null: false
    t.datetime "timestamp", default: -> { "CURRENT_TIMESTAMP" }
    t.integer "duration", default: 0
    t.boolean "completed", default: false
    t.string "source"
    t.string "ip_address"
    t.string "device_type", default: "desktop"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["analytic_id"], name: "index_views_on_analytic_id"
    t.index ["device_type"], name: "index_views_on_device_type"
    t.index ["timestamp"], name: "index_views_on_timestamp"
  end

  create_table "works", force: :cascade do |t|
    t.string "title", null: false
    t.text "description"
    t.string "thumbnail_url", default: ""
    t.string "thumbnail_video_url", default: ""
    t.integer "duration_seconds", default: 0
    t.string "rating"
    t.string "release_date"
    t.string "cast"
    t.string "studio"
    t.string "tags", default: [], array: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["title"], name: "index_works_on_title"
  end

  add_foreign_key "episodes", "works"
  add_foreign_key "short_clips", "works"
  add_foreign_key "views", "analytics"
end
