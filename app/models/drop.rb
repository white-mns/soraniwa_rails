class Drop < ApplicationRecord
	belongs_to :drop,   :foreign_key => :drop_id,   :primary_key => :proper_id, :class_name => 'ProperName'
	belongs_to :ap,     :foreign_key => :ap_no,   :primary_key => :ap_no, :class_name => 'Ap'

    scope :where_leader, -> (params) {
        if params["leader_e_no_form"] || params["leader_name_form"] then
            query = Party.includes(:pc_name).search(params[:q]).result.select(:ap_no)
            where(ap_no: query)
        end
    }
end
