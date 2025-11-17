class Skill < ApplicationRecord

    def self.ransackable_attributes(auth_object = nil)
      column_names
    end

    def self.ransackable_associations(auth_object = nil)
      Array(reflect_on_all_associations).map(&:name).map(&:to_s)
    end

	belongs_to :pc_name, :foreign_key => [:e_no], :primary_key => [:e_no], :class_name => 'Name'
	belongs_to :status, :foreign_key => [:e_no, :created_at], :primary_key => [:e_no, :created_at], :class_name => 'Status'
	belongs_to :type,   :foreign_key => :type_id,   :primary_key => :type_id,   :class_name => 'TypeName'
	belongs_to :nature, :foreign_key => :nature_id, :primary_key => :proper_id, :class_name => 'ProperName'
	belongs_to :timing, :foreign_key => :timing_id, :primary_key => :proper_id, :class_name => 'ProperName'
	belongs_to :skill,  :foreign_key => :skill_id,  :primary_key => :skill_id,  :class_name => 'SkillDatum'

    scope :where_old_top, ->(show_old_top, params) {
        if show_old_top == "1" then
                skill_ids  = []

                params_copy = {}
                params_copy[:q] = {}
                params[:q].each do |key, value|
                    if key.include?("skill") || key.include?("e_no") || key.include?("pc_name") then
                        params_copy[:q][key] = value
                    end
                end
                skill_ids << Hash[*Skill.where(created_at: params["old_rank_date_form"]).group(:skill_id).order("count desc").limit(params["old_rank_num_form"].to_i).ransack(params_copy[:q]).result.pluck("skill_id", "COUNT(*) as count").flatten].keys

            where(skill_id: skill_ids.flatten)
        end
    }

    scope :where_old_user_top, ->(show_old_top, params) {
        if show_old_top == "1" then
                skill_ids  = []

                params_copy = {}
                params_copy[:q] = {}
                params[:q].each do |key, value|
                    if key.include?("skill") || key.include?("e_no") || key.include?("pc_name") then
                        params_copy[:q][key] = value
                    end
                end
                skill_ids = Hash[*Skill.where(created_at: params["old_rank_date_form"]).group(:skill_id).order("count desc").limit(params["old_rank_num_form"].to_i).ransack(params_copy[:q]).result.pluck("skill_id", "COUNT(DISTINCT e_no) as count").flatten].keys

            where(skill_id: skill_ids.flatten)
        end
    }

    scope :where_old_user_top_ids, ->(show_old_top, params) {
          Skill.count()
    }

    scope :to_skill_history_graph, ->(params, column) {
        skill_name = Hash[*SkillDatum.pluck(:skill_id, :name).flatten]
        
        self.pluck(:created_at, column).inject(Hash.new(0)){|hash, a| 
            hash[ [skill_name[a[1]], a[0]] ] += 1;
            hash}
    }
end
