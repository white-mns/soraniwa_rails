class NewDropsController < ApplicationController
  include MyUtility
  before_action :set_new_drop, only: [:show, :edit, :update, :destroy]

  # GET /new_drops
  def index
    placeholder_set
    param_set
    @count	= NewDrop.notnil_date().includes(:drop, :ap).ransack(params[:q]).result.hit_count()
    @search	= NewDrop.notnil_date().includes(:drop, :ap).page(params[:page]).ransack(params[:q])
    @search.sorts = "ap_created_at desc" if @search.sorts.empty?
    @new_drops	= @search.result.per(50)
  end

  def param_set
    @form_params = {}

    @latest_created = UploadedCheck.maximum("created_at")

    params_clean(params)
    if !params["is_form"] then
        params["created_at_gteq_form"] ||= (@latest_created - 1.weeks).to_date.to_s
        params["created_at_lteq_form"] ||= @latest_created.to_date.to_s
    end

    params_to_form(params, @form_params, column_name: "pc_name_name", params_name: "pc_name_form", type: "text")
    params_to_form(params, @form_params, column_name: "ap_no", params_name: "ap_no_form", type: "number")
    params_to_form(params, @form_params, column_name: "drop_id", params_name: "drop_id_form", type: "number")

    params_to_form(params, @form_params, column_name: "drop_name", params_name: "drop_form", type: "text")

    params[:q]["ap_created_at_gteq"] = params["created_at_gteq_form"] && params["created_at_gteq_form"] != "" ? params["created_at_gteq_form"] + " 00:00:00" : nil;
    params[:q]["ap_created_at_lteq"] = params["created_at_lteq_form"] && params["created_at_lteq_form"] != "" ? params["created_at_lteq_form"] + " 23:59:00" : nil;

    @form_params["created_at_gteq_form"] = params["created_at_gteq_form"]
    @form_params["created_at_lteq_form"] = params["created_at_lteq_form"]
  end
  # GET /new_drops/1
  #def show
  #end

  # GET /new_drops/new
  #def new
  #  @new_drop = NewDrop.new
  #end

  # GET /new_drops/1/edit
  #def edit
  #end

  # POST /new_drops
  #def create
  #  @new_drop = NewDrop.new(new_drop_params)

  #  if @new_drop.save
  #    redirect_to @new_drop, notice: "New drop was successfully created."
  #  else
  #    render action: "new"
  #  end
  #end

  # PATCH/PUT /new_drops/1
  #def update
  #  if @new_drop.update(new_drop_params)
  #    redirect_to @new_drop, notice: "New drop was successfully updated."
  #  else
  #    render action: "edit"
  #  end
  #end

  # DELETE /new_drops/1
  #def destroy
  #  @new_drop.destroy
  #  redirect_to new_drops_url, notice: "New drop was successfully destroyed."
  #end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_new_drop
      @new_drop = NewDrop.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def new_drop_params
      params.require(:new_drop).permit(:ap_no, :drop_id)
    end
end
