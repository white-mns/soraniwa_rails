class DropsController < ApplicationController
  include MyUtility
  before_action :set_drop, only: [:show, :edit, :update, :destroy]

  # GET /drops
  def index
    placeholder_set
    param_set
    @count	= Drop.notnil_date().includes(:drop, [ap: [:garden, leader: :pc_name]]).where_leader(@params_leader).search(params[:q]).result.hit_count()
    @search	= Drop.notnil_date().includes(:drop, [ap: [:garden, leader: :pc_name]]).where_leader(@params_leader).page(params[:page]).search(params[:q])
    @search.sorts = "ap_no desc" if @search.sorts.empty?
    @drops	= @search.result.per(50)
  end

  def param_set
    @form_params = {}

    @latest_created = UploadedCheck.maximum("created_at")
    
    params_clean(params)

    @params_leader  = params.dup
    @params_leader[:q]["party_order_eq"] = 0

    if !params["is_form"] then
        params["created_at_lteq_form"] ||= @latest_created.to_date.to_s
    end

    params_to_form(params, @form_params, column_name: "pc_name_name", params_name: "pc_name_form", type: "text")
    params_to_form(params, @form_params, column_name: "ap_no", params_name: "ap_no_form", type: "number")
    params_to_form(params, @form_params, column_name: "drop_id", params_name: "drop_id_form", type: "number")
    params_to_form(params, @form_params, column_name: "drop_name", params_name: "drop_form", type: "text")

    params_to_form(params, @form_params, column_name: "ap_garden_id", params_name: "garden_id_form", type: "number")
    params_to_form(params, @form_params, column_name: "ap_garden_name", params_name: "garden_form", type: "text")
    params_to_form(params, @form_params, column_name: "ap_progress", params_name: "progress_form", type: "number")

    params_to_form(@params_leader, @form_params, column_name: "e_no", params_name: "leader_e_no_form", type: "number")
    params_to_form(@params_leader, @form_params, column_name: "pc_name_name", params_name: "leader_name_form", type: "text")

    params[:q]["ap_created_at_gteq"] = params["created_at_gteq_form"] && params["created_at_gteq_form"] != "" ? params["created_at_gteq_form"] + " 00:00:00" : nil;
    params[:q]["ap_created_at_lteq"] = params["created_at_lteq_form"] && params["created_at_lteq_form"] != "" ? params["created_at_lteq_form"] + " 23:59:00" : nil;

    @form_params["created_at_gteq_form"] = params["created_at_gteq_form"]
    @form_params["created_at_lteq_form"] = params["created_at_lteq_form"]

    toggle_params_to_variable(params, @form_params, params_name: "show_ap_no")
    toggle_params_to_variable(params, @form_params, params_name: "show_date", first_opened: true)
    @form_params["base_first"]    = (!params["is_form"]) ? "1" : "0"
  end
  # GET /drops/1
  #def show
  #end

  # GET /drops/new
  #def new
  #  @drop = Drop.new
  #end

  # GET /drops/1/edit
  #def edit
  #end

  # POST /drops
  #def create
  #  @drop = Drop.new(drop_params)

  #  if @drop.save
  #    redirect_to @drop, notice: "Drop was successfully created."
  #  else
  #    render action: "new"
  #  end
  #end

  # PATCH/PUT /drops/1
  #def update
  #  if @drop.update(drop_params)
  #    redirect_to @drop, notice: "Drop was successfully updated."
  #  else
  #    render action: "edit"
  #  end
  #end

  # DELETE /drops/1
  #def destroy
  #  @drop.destroy
  #  redirect_to drops_url, notice: "Drop was successfully destroyed."
  #end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_drop
      @drop = Drop.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def drop_params
      params.require(:drop).permit(:ap_no, :drop_id)
    end
end
