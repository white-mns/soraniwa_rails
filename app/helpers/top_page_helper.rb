module TopPageHelper
    def top_date_text(created_at, uploaded)
        if !created_at then return "---" end
        
        text = created_at.to_s(:jp_date)

        if created_at == uploaded then
            text += " 早朝のデータまで反映しています"
        else
            text += " のデータに更新中です…"
        end

        text
    end
end
