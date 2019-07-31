class ApplicationController < ActionController::Base
    def placeholder_set
        @placeholder = {}
        @placeholder["Number"] = "例）1~10/50~100"
        @placeholder["Text"]   = "例）武器/\"防具\""
        @placeholder["Name"]   = "例）太郎/\"次郎\""
        @placeholder["Skill"]  = "例）レスト/\"マナ\""
        @placeholder["Cost"]  = "例）SP40/SP30+MP30"
        @placeholder["SkillText"]  = "例）SP回復/物理攻撃"
        @placeholder["Type"]   = "例）平穏/闘志"
        @placeholder["FanFlower"]   = "例）ビギナ/アリス"
        @placeholder["Timing"]   = "例）常時/4行動毎"
        @placeholder["Item"]   = "例）武器/\"防具\""
        @placeholder["Garden"]   = "例）はじまりの場所/おだやかな草原"
    end
end
