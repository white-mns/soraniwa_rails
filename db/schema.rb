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

ActiveRecord::Schema.define(version: 2019_07_28_020538) do

  create_table "names", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin", force: :cascade do |t|
    t.integer "e_no"
    t.string "name"
    t.string "nickname"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["e_no"], name: "index_names_on_e_no"
    t.index ["name"], name: "index_names_on_name"
    t.index ["nickname"], name: "index_names_on_nickname"
  end

  create_table "proper_names", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin", force: :cascade do |t|
    t.integer "proper_id"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_proper_names_on_name"
    t.index ["proper_id"], name: "index_proper_names_on_proper_id"
  end

  create_table "skill_data", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin", force: :cascade do |t|
    t.integer "skill_id"
    t.string "name"
    t.integer "cost_id"
    t.string "text"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cost_id"], name: "index_skill_data_on_cost_id"
    t.index ["name"], name: "index_skill_data_on_name"
    t.index ["skill_id"], name: "index_skill_data_on_skill_id"
  end

  create_table "skills", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin", force: :cascade do |t|
    t.integer "e_no"
    t.integer "set_no"
    t.integer "skill_type_id"
    t.integer "type_id"
    t.integer "nature_id"
    t.integer "skill_id"
    t.string "name"
    t.integer "timing_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["e_no", "created_at", "set_no"], name: "createdat_and_eno"
    t.index ["nature_id"], name: "index_skills_on_nature_id"
    t.index ["skill_type_id"], name: "index_skills_on_skill_type_id"
    t.index ["timing_id"], name: "index_skills_on_timing_id"
    t.index ["type_id"], name: "index_skills_on_type_id"
  end

  create_table "statuses", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin", force: :cascade do |t|
    t.integer "e_no"
    t.integer "str"
    t.integer "mag"
    t.integer "agi"
    t.integer "vit"
    t.integer "dex"
    t.integer "mnt"
    t.integer "type_id"
    t.integer "fan_of_flower_id"
    t.integer "line_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["agi"], name: "index_statuses_on_agi"
    t.index ["created_at"], name: "index_statuses_on_created_at"
    t.index ["dex"], name: "index_statuses_on_dex"
    t.index ["e_no", "created_at"], name: "createdat_and_eno"
    t.index ["fan_of_flower_id"], name: "index_statuses_on_fan_of_flower_id"
    t.index ["line_id"], name: "index_statuses_on_line_id"
    t.index ["mag"], name: "index_statuses_on_mag"
    t.index ["mnt"], name: "index_statuses_on_mnt"
    t.index ["str"], name: "index_statuses_on_str"
    t.index ["type_id"], name: "index_statuses_on_type_id"
    t.index ["vit"], name: "index_statuses_on_vit"
  end

  create_table "type_names", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin", force: :cascade do |t|
    t.integer "type_id"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_type_names_on_name"
    t.index ["type_id"], name: "index_type_names_on_type_id"
  end

  create_table "uploaded_checks", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
