class EnemiesController < ApplicationController
  include MyUtility
  before_action :set_enemy, only: [:show, :edit, :update, :destroy]

  # GET /enemies
  def index
    placeholder_set
    param_set
    @count	= Enemy.notnil_date().includes(:enemy, :suffix).search(params[:q]).result.hit_count()
    @search	= Enemy.notnil_date().includes(:enemy, :suffix).page(params[:page]).search(params[:q])
    @search.sorts = "id asc" if @search.sorts.empty?
    @enemies	= @search.result.per(50)
  end

  def param_set
    @form_params = {}

    @latest_created = UploadedCheck.maximum("created_at")

    params_clean(params)
    if !params["is_form"] then
        #params["created_at_gteq_form"] ||= (@latest_created - 1.weeks).to_date.to_s
        params["created_at_lteq_form"] ||= @latest_created.to_date.to_s
    end

    params_to_form(params, @form_params, column_name: "ap_no", params_name: "ap_no_form", type: "number")
    params_to_form(params, @form_params, column_name: "enemy_id", params_name: "enemy_id_form", type: "number")
    params_to_form(params, @form_params, column_name: "suffix_id", params_name: "suffix_id_form", type: "number")

    params_to_form(params, @form_params, column_name: "enemy_name", params_name: "enemy_form", type: "text")
  end
  # GET /enemies/1
  #def show
  #end

  # GET /enemies/new
  #def new
  #  @enemy = Enemy.new
  #end

  # GET /enemies/1/edit
  #def edit
  #end

  # POST /enemies
  #def create
  #  @enemy = Enemy.new(enemy_params)

  #  if @enemy.save
  #    redirect_to @enemy, notice: "Enemy was successfully created."
  #  else
  #    render action: "new"
  #  end
  #end

  # PATCH/PUT /enemies/1
  #def update
  #  if @enemy.update(enemy_params)
  #    redirect_to @enemy, notice: "Enemy was successfully updated."
  #  else
  #    render action: "edit"
  #  end
  #end

  # DELETE /enemies/1
  #def destroy
  #  @enemy.destroy
  #  redirect_to enemies_url, notice: "Enemy was successfully destroyed."
  #end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_enemy
      @enemy = Enemy.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def enemy_params
      params.require(:enemy).permit(:ap_no, :enemy_id, :suffix_id)
    end
end
