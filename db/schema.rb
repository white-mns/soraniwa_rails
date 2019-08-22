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

ActiveRecord::Schema.define(version: 2019_08_22_083606) do

  create_table "aps", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin", force: :cascade do |t|
    t.integer "ap_no"
    t.integer "action_type"
    t.integer "garden_id"
    t.integer "progress"
    t.integer "party_num"
    t.integer "enemy_num"
    t.integer "battle_result"
    t.integer "special_battle"
    t.integer "is_practice"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["action_type"], name: "index_aps_on_action_type"
    t.index ["ap_no"], name: "index_aps_on_ap_no", unique: true
    t.index ["battle_result"], name: "index_aps_on_battle_result"
    t.index ["created_at", "ap_no"], name: "createdat_apno"
    t.index ["created_at"], name: "index_aps_on_created_at"
    t.index ["enemy_num"], name: "index_aps_on_enemy_num"
    t.index ["garden_id"], name: "index_aps_on_garden_id"
    t.index ["is_practice"], name: "index_aps_on_is_practice"
    t.index ["party_num"], name: "index_aps_on_party_num"
    t.index ["progress"], name: "index_aps_on_progress"
    t.index ["special_battle"], name: "index_aps_on_special_battle"
  end

  create_table "drops", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin", force: :cascade do |t|
    t.integer "ap_no"
    t.integer "drop_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ap_no"], name: "index_drops_on_ap_no"
    t.index ["drop_id"], name: "index_drops_on_drop_id"
  end

  create_table "enemies", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin", force: :cascade do |t|
    t.integer "ap_no"
    t.integer "enemy_id"
    t.integer "suffix_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ap_no"], name: "index_enemies_on_ap_no"
    t.index ["enemy_id"], name: "index_enemies_on_enemy_id"
    t.index ["suffix_id"], name: "index_enemies_on_suffix_id"
  end

  create_table "enemy_data", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin", force: :cascade do |t|
    t.integer "enemy_id"
    t.string "name"
    t.integer "line_id"
    t.integer "type_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["enemy_id"], name: "index_enemy_data_on_enemy_id"
    t.index ["line_id"], name: "index_enemy_data_on_line_id"
    t.index ["name"], name: "index_enemy_data_on_name"
    t.index ["type_id"], name: "index_enemy_data_on_type_id"
  end

  create_table "garden_names", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin", force: :cascade do |t|
    t.integer "garden_id"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["garden_id"], name: "index_garden_names_on_garden_id"
    t.index ["name"], name: "index_garden_names_on_name"
  end

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

  create_table "new_drops", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin", force: :cascade do |t|
    t.integer "ap_no"
    t.integer "drop_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ap_no"], name: "index_new_drops_on_ap_no"
    t.index ["drop_id"], name: "index_new_drops_on_drop_id"
  end

  create_table "new_skills", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin", force: :cascade do |t|
    t.integer "skill_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["skill_id"], name: "index_new_skills_on_skill_id"
  end

  create_table "parties", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin", force: :cascade do |t|
    t.integer "ap_no"
    t.integer "e_no"
    t.integer "party_order"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ap_no", "e_no"], name: "apno_eno"
    t.index ["party_order"], name: "index_parties_on_party_order"
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
    t.integer "use_number"
    t.index ["e_no", "created_at", "set_no"], name: "createdat_and_eno"
    t.index ["nature_id"], name: "index_skills_on_nature_id"
    t.index ["skill_type_id"], name: "index_skills_on_skill_type_id"
    t.index ["timing_id"], name: "index_skills_on_timing_id"
    t.index ["type_id"], name: "index_skills_on_type_id"
    t.index ["use_number"], name: "index_skills_on_use_number"
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
