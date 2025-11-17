class StatusesController < ApplicationController
  include MyUtility
  before_action :set_status, only: [:show, :edit, :update, :destroy]

  # GET /statuses
  def index
    placeholder_set
    param_set
    @count	= Status.notnil_date().includes(:pc_name, :type, :fan_of_flower).ransack(params[:q]).result.hit_count()
    @search	= Status.notnil_date().includes(:pc_name, :type, :fan_of_flower).page(params[:page]).ransack(params[:q])
    @search.sorts = "id asc" if @search.sorts.empty?
    @statuses	= @search.result.per(50)
  end

  # GET /status/graphs
  def graphs
    placeholder_set
    param_set
    @count	= Status.notnil_date().includes(:pc_name, :type, :fan_of_flower).ransack(params[:q]).result.hit_count()
    @search	= Status.notnil_date().includes(:pc_name, :type, :fan_of_flower).page(params[:page]).ransack(params[:q])
    @search.sorts = "id asc" if @search.sorts.empty?
    @statuses	= @search.result.per(50)

    @library_param = {
        backgroundColor: "#fffcf8"
    }
  end


  def param_set
    @form_params = {}

    @latest_created = UploadedCheck.maximum("created_at")

    params_clean(params)
    if !params["is_form"] then
        params["created_at_gteq_form"] ||= @latest_created.to_date.to_s
        params["created_at_lteq_form"] ||= @latest_created.to_date.to_s
    end

    params_to_form(params, @form_params, column_name: "pc_name_name", params_name: "pc_name_form", type: "text")
    params_to_form(params, @form_params, column_name: "e_no", params_name: "e_no_form", type: "number")
    params_to_form(params, @form_params, column_name: "str", params_name: "str_form", type: "number")
    params_to_form(params, @form_params, column_name: "mag", params_name: "mag_form", type: "number")
    params_to_form(params, @form_params, column_name: "agi", params_name: "agi_form", type: "number")
    params_to_form(params, @form_params, column_name: "vit", params_name: "vit_form", type: "number")
    params_to_form(params, @form_params, column_name: "dex", params_name: "dex_form", type: "number")
    params_to_form(params, @form_params, column_name: "mnt", params_name: "mnt_form", type: "number")
    params_to_form(params, @form_params, column_name: "type_id", params_name: "type_id_form", type: "number")
    params_to_form(params, @form_params, column_name: "fan_of_flower_id", params_name: "fan_of_flower_id_form", type: "number")
    params_to_form(params, @form_params, column_name: "line_id", params_name: "line_id_form", type: "number")
    params_to_form(params, @form_params, column_name: "created_at", params_name: "created_at_form", type: "number")

    params_to_form(params, @form_params, column_name: "type_name", params_name: "type_form", type: "text")
    params_to_form(params, @form_params, column_name: "fan_of_flower_name", params_name: "fan_of_flower_form", type: "text")

    checkbox_params_set_query_any(params, @form_params, query_name: "line_id_eq_any",
                             checkboxes: [{params_name: "is_front", value: 0},
                                          {params_name: "is_back",  value: 1}])

    params[:q]["created_at_gteq"] = params["created_at_gteq_form"] && params["created_at_gteq_form"] != "" ? params["created_at_gteq_form"] + " 00:00:00" : nil;
    params[:q]["created_at_lteq"] = params["created_at_lteq_form"] && params["created_at_lteq_form"] != "" ? params["created_at_lteq_form"] + " 23:59:00" : nil;

    @form_params["created_at_gteq_form"] = params["created_at_gteq_form"]
    @form_params["created_at_lteq_form"] = params["created_at_lteq_form"]
  end
  # GET /statuses/1
  #def show
  #end

  # GET /statuses/new
  #def new
  #  @status = Status.new
  #end

  # GET /statuses/1/edit
  #def edit
  #end

  # POST /statuses
  #def create
  #  @status = Status.new(status_params)

  #  if @status.save
  #    redirect_to @status, notice: "Status was successfully created."
  #  else
  #    render action: "new"
  #  end
  #end

  # PATCH/PUT /statuses/1
  #def update
  #  if @status.update(status_params)
  #    redirect_to @status, notice: "Status was successfully updated."
  #  else
  #    render action: "edit"
  #  end
  #end

  # DELETE /statuses/1
  #def destroy
  #  @status.destroy
  #  redirect_to statuses_url, notice: "Status was successfully destroyed."
  #end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_status
      @status = Status.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def status_params
      params.require(:status).permit(:e_no, :str, :mag, :agi, :vit, :dex, :mnt, :battle_type_id, :battle_type_color_id, :fan_of_flower_id, :line_id, :created_at)
    end
end
