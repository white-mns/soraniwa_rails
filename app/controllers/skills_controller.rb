class SkillsController < ApplicationController
  include MyUtility
  before_action :set_skill, only: [:show, :edit, :update, :destroy]

  # GET /skills
  def index
    placeholder_set
    param_set
    @count	= Skill.notnil_date().includes(:pc_name, :type, :nature, :timing, [skill: :cost], [status: :type]).ransack(params[:q]).result.hit_count()
    @search	= Skill.notnil_date().includes(:pc_name, :type, :nature, :timing, [skill: :cost], [status: :type]).page(params[:page]).ransack(params[:q])
    @search.sorts = "id asc" if @search.sorts.empty?
    @skills	= @search.result.per(50)
  end

  # GET /skill/history
  def history
    placeholder_set
    param_set
    @count	= Skill.notnil_date().includes(:pc_name, :type, :nature, :timing, [skill: :cost], [status: :type]).ransack(params[:q]).result.hit_count()
    @search	= Skill.notnil_date().includes(:pc_name, :type, :nature, :timing, [skill: :cost], [status: :type]).page(params[:page]).ransack(params[:q])
    @search.sorts = "id asc" if @search.sorts.empty?
    @skills	= @search.result.per(50)

    @library_param = {
        backgroundColor: "#fffcf8",
        hAxis: { format: 'MM/dd' }
    }
  end

  def param_set
    @form_params = {}

    @latest_created = UploadedCheck.maximum("created_at")

    params_clean(params)
    if !params["is_form"] then
        if action_name != "history" then
            params["created_at_gteq_form"] ||= @latest_created.to_date.to_s
        else
            params["created_at_gteq_form"] ||= (@latest_created - 2.months).to_date.to_s
            params["old_rank_date_form"] = @latest_created.to_date.to_s
            params["old_rank_num_form"] = 5
        end

        params["created_at_lteq_form"] ||= @latest_created.to_date.to_s
    end

    params_to_form(params, @form_params, column_name: "pc_name_name", params_name: "pc_name_form", type: "text")
    params_to_form(params, @form_params, column_name: "e_no", params_name: "e_no_form", type: "number")
    params_to_form(params, @form_params, column_name: "set_no", params_name: "set_no_form", type: "number")
    params_to_form(params, @form_params, column_name: "skill_type_id", params_name: "skill_type_id_form", type: "number")
    params_to_form(params, @form_params, column_name: "type_id", params_name: "type_id_form", type: "number")
    params_to_form(params, @form_params, column_name: "nature_id", params_name: "nature_id_form", type: "number")
    params_to_form(params, @form_params, column_name: "skill_id", params_name: "skill_id_form", type: "number")
    params_to_form(params, @form_params, column_name: "name", params_name: "name_form", type: "number")
    params_to_form(params, @form_params, column_name: "timing_id", params_name: "timing_id_form", type: "number")

    params_to_form(params, @form_params, column_name: "type_name", params_name: "type_form", type: "text")
    params_to_form(params, @form_params, column_name: "nature_name", params_name: "nature_form", type: "text")
    params_to_form(params, @form_params, column_name: "timing_name", params_name: "timing_form", type: "text")
    params_to_form(params, @form_params, column_name: "use_number", params_name: "use_number_form", type: "number")
    params_to_form(params, @form_params, column_name: "skill_name", params_name: "skill_form", type: "text")
    params_to_form(params, @form_params, column_name: "skill_cost_name", params_name: "cost_form", type: "text")
    params_to_form(params, @form_params, column_name: "skill_text", params_name: "skill_text_form", type: "text")

    params_to_form(params, @form_params, column_name: "status_str", params_name: "str_form", type: "number")
    params_to_form(params, @form_params, column_name: "status_mag", params_name: "mag_form", type: "number")
    params_to_form(params, @form_params, column_name: "status_agi", params_name: "agi_form", type: "number")
    params_to_form(params, @form_params, column_name: "status_vit", params_name: "vit_form", type: "number")
    params_to_form(params, @form_params, column_name: "status_dex", params_name: "dex_form", type: "number")
    params_to_form(params, @form_params, column_name: "status_mnt", params_name: "mnt_form", type: "number")
    params_to_form(params, @form_params, column_name: "status_type_name", params_name: "status_type_form", type: "text")

    params[:q]["created_at_gteq"] = params["created_at_gteq_form"] && params["created_at_gteq_form"] != "" ? params["created_at_gteq_form"] + " 00:00:00" : nil;
    params[:q]["created_at_lteq"] = params["created_at_lteq_form"] && params["created_at_lteq_form"] != "" ? params["created_at_lteq_form"] + " 23:59:00" : nil;

    @form_params["created_at_gteq_form"] = params["created_at_gteq_form"]
    @form_params["created_at_lteq_form"] = params["created_at_lteq_form"]

    @form_params["old_rank_date_form"] = params["old_rank_date_form"]
    @form_params["old_rank_num_form"] = params["old_rank_num_form"]

    toggle_params_to_variable(params, @form_params, params_name: "show_skill_text")
    toggle_params_to_variable(params, @form_params, params_name: "show_status")
    toggle_params_to_variable(params, @form_params, params_name: "show_status_type")
    toggle_params_to_variable(params, @form_params, params_name: "show_old_top", first_opened: true)
    @form_params["base_first"]    = (!params["is_form"]) ? "1" : "0"
  end
  # GET /skills/1
  #def show
  #end

  # GET /skills/new
  #def new
  #  @skill = Skill.new
  #end

  # GET /skills/1/edit
  #def edit
  #end

  # POST /skills
  #def create
  #  @skill = Skill.new(skill_params)

  #  if @skill.save
  #    redirect_to @skill, notice: "Skill was successfully created."
  #  else
  #    render action: "new"
  #  end
  #end

  # PATCH/PUT /skills/1
  #def update
  #  if @skill.update(skill_params)
  #    redirect_to @skill, notice: "Skill was successfully updated."
  #  else
  #    render action: "edit"
  #  end
  #end

  # DELETE /skills/1
  #def destroy
  #  @skill.destroy
  #  redirect_to skills_url, notice: "Skill was successfully destroyed."
  #end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_skill
      @skill = Skill.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def skill_params
      params.require(:skill).permit(:e_no, :set_no, :skill_type_id, :type_id, :nature_id, :skill_id, :name, :timing_id)
    end
end
