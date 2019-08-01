class Ap < ApplicationRecord
	belongs_to :garden,   :foreign_key => :garden_id,   :primary_key => :garden_id,   :class_name => 'GardenName'
	has_many :party_members, -> {order('party_order ASC')}, :foreign_key => :ap_no, :primary_key => :ap_no, :class_name => 'Party'
	has_many :enemy_members, :foreign_key => :ap_no, :primary_key => :ap_no, :class_name => 'Enemy'
	belongs_to :leader,         -> { where(party_order: 0)},    :foreign_key => :ap_no, :primary_key => :ap_no, :class_name => 'Party'
	has_many   :fellow_members, -> { where(party_order: 1..4)}, :foreign_key => :ap_no, :primary_key => :ap_no, :class_name => 'Party'

    scope :where_members, -> (params) {
        if params["party_members_e_no_form"] || params["party_members_name_form"] then
            query = Party.includes(:pc_name).search(params[:q]).result.select(:ap_no)
            where(ap_no: query)
        end
    }
    scope :where_leader, -> (params) {
        if params["leader_e_no_form"] || params["leader_name_form"] then
            query = Party.includes(:pc_name).search(params[:q]).result.select(:ap_no)
            where(ap_no: query)
        end
    }

    scope :where_fellows, -> (params) {
        if params["fellow_members_e_no_form"] || params["fellow_members_name_form"] then
            query = Party.includes(:pc_name).search(params[:q]).result.select(:ap_no)
            where(ap_no: query)
        end
    }

end
