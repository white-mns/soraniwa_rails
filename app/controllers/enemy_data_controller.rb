class EnemyDataController < ApplicationController
  include MyUtility
  before_action :set_enemy_datum, only: [:show, :edit, :update, :destroy]

  # GET /enemy_data
  def index
    placeholder_set
    param_set
    @count	= EnemyDatum.includes(:type).ransack(params[:q]).result.hit_count()
    @search	= EnemyDatum.includes(:type).page(params[:page]).ransack(params[:q])
    @search.sorts = "id asc" if @search.sorts.empty?
    @enemy_data	= @search.result.per(50)
  end

  def param_set
    @form_params = {}

    params_clean(params)

    params_to_form(params, @form_params, column_name: "enemy_id", params_name: "enemy_id_form", type: "number")
    params_to_form(params, @form_params, column_name: "name", params_name: "name_form", type: "text")
    params_to_form(params, @form_params, column_name: "line_id", params_name: "line_id_form", type: "number")
    params_to_form(params, @form_params, column_name: "type_id", params_name: "type_id_form", type: "number")

    params_to_form(params, @form_params, column_name: "type_name", params_name: "type_form", type: "text")

    checkbox_params_set_query_any(params, @form_params, query_name: "line_id_eq_any",
                             checkboxes: [{params_name: "is_front", value: 0},
                                          {params_name: "is_back",  value: 1}])

  end
  # GET /enemy_data/1
  #def show
  #end

  # GET /enemy_data/new
  #def new
  #  @enemy_datum = EnemyDatum.new
  #end

  # GET /enemy_data/1/edit
  #def edit
  #end

  # POST /enemy_data
  #def create
  #  @enemy_datum = EnemyDatum.new(enemy_datum_params)

  #  if @enemy_datum.save
  #    redirect_to @enemy_datum, notice: "Enemy datum was successfully created."
  #  else
  #    render action: "new"
  #  end
  #end

  # PATCH/PUT /enemy_data/1
  #def update
  #  if @enemy_datum.update(enemy_datum_params)
  #    redirect_to @enemy_datum, notice: "Enemy datum was successfully updated."
  #  else
  #    render action: "edit"
  #  end
  #end

  # DELETE /enemy_data/1
  #def destroy
  #  @enemy_datum.destroy
  #  redirect_to enemy_data_url, notice: "Enemy datum was successfully destroyed."
  #end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_enemy_datum
      @enemy_datum = EnemyDatum.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def enemy_datum_params
      params.require(:enemy_datum).permit(:enemy_id, :name, :line_id, :type_id)
    end
end
