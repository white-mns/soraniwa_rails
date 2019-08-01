module ApHelper
    def action_type_text(ap)
        if    ap.action_type == 0 then return "花壇の世話"
        elsif ap.action_type == 1 then return "庭園の散策"
        elsif ap.action_type == 2 then return "島の探検"
        end
    end

    def progress_text(ap)
        if ap.progress >= 0 then return ap.progress
        elsif ap.progress == -1 then return ""
        elsif ap.progress == -11 then return "メイン"
        else
            return "？"
        end
    end

    def battle_result_text(ap)
        if    ap.battle_result == -2  then return "なし"
        elsif ap.battle_result == 1  then return "勝利"
        elsif ap.battle_result == 0  then return "引分"
        elsif ap.battle_result == -1 then return "敗北"
        else
            return "？"
        end
    end

    def flag_text(text)
        if    text == 0  then return ""
        elsif text == 1  then return "○"
        end
    end

    def party_members(members)
        if !members then
            return
        end

        members.each do |member|
          haml_concat member.pc_name.name if member.pc_name
          haml_concat "(" + sprintf("%d", member.e_no) + ")"
          haml_tag :br
        end
    end

    def enemy_members(members)
        if !members then
            return
        end

        members.each do |member|
          haml_concat member.enemy.name if member.enemy
          haml_concat member.suffix.name if member.enemy
          haml_tag :br
        end
    end
end
