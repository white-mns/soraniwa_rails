class GardenNamesController < ApplicationController
  include MyUtility
  before_action :set_garden_name, only: [:show, :edit, :update, :destroy]

  # GET /garden_names
  def index
    placeholder_set
    param_set
    @count	= GardenName.search(params[:q]).result.hit_count()
    @search	= GardenName.page(params[:page]).search(params[:q])
    @search.sorts = "id asc" if @search.sorts.empty?
    @garden_names	= @search.result.per(50)
  end

  def param_set
    @form_params = {}

    params_clean(params)

    params_to_form(params, @form_params, column_name: "garden_id", params_name: "garden_id_form", type: "number")
    params_to_form(params, @form_params, column_name: "name", params_name: "name_form", type: "text")
  end
  # GET /garden_names/1
  #def show
  #end

  # GET /garden_names/new
  #def new
  #  @garden_name = GardenName.new
  #end

  # GET /garden_names/1/edit
  #def edit
  #end

  # POST /garden_names
  #def create
  #  @garden_name = GardenName.new(garden_name_params)

  #  if @garden_name.save
  #    redirect_to @garden_name, notice: "Garden name was successfully created."
  #  else
  #    render action: "new"
  #  end
  #end

  # PATCH/PUT /garden_names/1
  #def update
  #  if @garden_name.update(garden_name_params)
  #    redirect_to @garden_name, notice: "Garden name was successfully updated."
  #  else
  #    render action: "edit"
  #  end
  #end

  # DELETE /garden_names/1
  #def destroy
  #  @garden_name.destroy
  #  redirect_to garden_names_url, notice: "Garden name was successfully destroyed."
  #end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_garden_name
      @garden_name = GardenName.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def garden_name_params
      params.require(:garden_name).permit(:garden_id, :name)
    end
end
