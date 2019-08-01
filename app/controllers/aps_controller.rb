class ApsController < ApplicationController
  include MyUtility
  before_action :set_ap, only: [:show, :edit, :update, :destroy]

  # GET /aps
  def index
    placeholder_set
    param_set
    @count	= Ap.notnil_date().includes(:garden).search(params[:q]).result.hit_count()
    @search	= Ap.notnil_date().includes(:garden).page(params[:page]).search(params[:q])
    @search.sorts = "id asc" if @search.sorts.empty?
    @aps	= @search.result.per(50)
  end

  def param_set
    @form_params = {}

    @latest_created = UploadedCheck.maximum("created_at")

    params_clean(params)
    if !params["is_form"] then
        #params["created_at_gteq_form"] ||= (@latest_created - 1.weeks).to_date.to_s
        params["created_at_lteq_form"] ||= @latest_created.to_date.to_s
    end

    params_to_form(params, @form_params, column_name: "pc_name_name", params_name: "pc_name_form", type: "text")
    params_to_form(params, @form_params, column_name: "ap_no", params_name: "ap_no_form", type: "number")
    params_to_form(params, @form_params, column_name: "action_type", params_name: "action_type_form", type: "number")
    params_to_form(params, @form_params, column_name: "garden_id", params_name: "garden_id_form", type: "number")
    params_to_form(params, @form_params, column_name: "progress", params_name: "progress_form", type: "number")
    params_to_form(params, @form_params, column_name: "party_num", params_name: "party_num_form", type: "number")
    params_to_form(params, @form_params, column_name: "enemy_num", params_name: "enemy_num_form", type: "number")
    params_to_form(params, @form_params, column_name: "special_battle", params_name: "special_battle_form", type: "number")
    params_to_form(params, @form_params, column_name: "battle_result", params_name: "battle_result_form", type: "number")
    params_to_form(params, @form_params, column_name: "created_at", params_name: "created_at_form", type: "number")

    params_to_form(params, @form_params, column_name: "garden_name", params_name: "garden_form", type: "text")

    checkbox_params_set_query_any(params, @form_params, query_name: "action_type_eq_any",
                             checkboxes: [{params_name: "is_care", value: 0},
                                          {params_name: "is_stroll",  value: 1},
                                          {params_name: "is_exploration",  value: 2}])

    checkbox_params_set_query_any(params, @form_params, query_name: "special_battle_eq_any",
                             checkboxes: [{params_name: "no_special", value: 0},
                                          {params_name: "is_special",  value: 1}])

    checkbox_params_set_query_any(params, @form_params, query_name: "is_practice_eq_any",
                             checkboxes: [{params_name: "no_practice", value: 0},
                                          {params_name: "is_practice",  value: 1}])

    checkbox_params_set_query_any(params, @form_params, query_name: "battle_result_eq_any",
                             checkboxes: [{params_name: "no_win", value: -2},
                                          {params_name: "is_win",  value: 1},
                                          {params_name: "is_draw",  value: 0},
                                          {params_name: "is_lose",  value: -1}])

    params[:q]["created_at_gteq"] = params["created_at_gteq_form"] && params["created_at_gteq_form"] != "" ? params["created_at_gteq_form"] + " 00:00:00" : nil;
    params[:q]["created_at_lteq"] = params["created_at_lteq_form"] && params["created_at_lteq_form"] != "" ? params["created_at_lteq_form"] + " 23:59:00" : nil;

    @form_params["created_at_gteq_form"] = params["created_at_gteq_form"]
    @form_params["created_at_lteq_form"] = params["created_at_lteq_form"]

    toggle_params_to_variable(params, @form_params, params_name: "show_num")
    toggle_params_to_variable(params, @form_params, params_name: "show_special")
    toggle_params_to_variable(params, @form_params, params_name: "show_ap_no")
    toggle_params_to_variable(params, @form_params, params_name: "show_date", first_opened: true)
    toggle_params_to_variable(params, @form_params, params_name: "show_battle_result")
    @form_params["base_first"]    = (!params["is_form"]) ? "1" : "0"
  end
  # GET /aps/1
  #def show
  #end

  # GET /aps/new
  #def new
  #  @ap = Ap.new
  #end

  # GET /aps/1/edit
  #def edit
  #end

  # POST /aps
  #def create
  #  @ap = Ap.new(ap_params)

  #  if @ap.save
  #    redirect_to @ap, notice: "Ap was successfully created."
  #  else
  #    render action: "new"
  #  end
  #end

  # PATCH/PUT /aps/1
  #def update
  #  if @ap.update(ap_params)
  #    redirect_to @ap, notice: "Ap was successfully updated."
  #  else
  #    render action: "edit"
  #  end
  #end

  # DELETE /aps/1
  #def destroy
  #  @ap.destroy
  #  redirect_to aps_url, notice: "Ap was successfully destroyed."
  #end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ap
      @ap = Ap.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def ap_params
      params.require(:ap).permit(:ap_no, :action_type, :garden_id, :progress, :party_num, :enemy_num, :special_battle, :battle_result, :created_at)
    end
end
