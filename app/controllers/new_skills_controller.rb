class NewSkillsController < ApplicationController
  include MyUtility
  before_action :set_new_skill, only: [:show, :edit, :update, :destroy]

  # GET /new_skills
  def index
    placeholder_set
    param_set
    @count	= NewSkill.notnil_date().includes(:skill).ransack(params[:q]).result.hit_count()
    @search	= NewSkill.notnil_date().includes(:skill).page(params[:page]).ransack(params[:q])
    @search.sorts = "created_at desc" if @search.sorts.empty?
    @new_skills	= @search.result.per(50)
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
    params_to_form(params, @form_params, column_name: "skill_id", params_name: "skill_id_form", type: "number")

    params_to_form(params, @form_params, column_name: "skill_name", params_name: "skill_form", type: "text")
    params_to_form(params, @form_params, column_name: "skill_cost_name", params_name: "cost_form", type: "text")
    params_to_form(params, @form_params, column_name: "skill_text", params_name: "skill_text_form", type: "text")

    params[:q]["created_at_gteq"] = params["created_at_gteq_form"] && params["created_at_gteq_form"] != "" ? params["created_at_gteq_form"] + " 00:00:00" : nil;
    params[:q]["created_at_lteq"] = params["created_at_lteq_form"] && params["created_at_lteq_form"] != "" ? params["created_at_lteq_form"] + " 23:59:00" : nil;

    @form_params["created_at_gteq_form"] = params["created_at_gteq_form"]
    @form_params["created_at_lteq_form"] = params["created_at_lteq_form"]
  end
  # GET /new_skills/1
  #def show
  #end

  # GET /new_skills/new
  #def new
  #  @new_skill = NewSkill.new
  #end

  # GET /new_skills/1/edit
  #def edit
  #end

  # POST /new_skills
  #def create
  #  @new_skill = NewSkill.new(new_skill_params)

  #  if @new_skill.save
  #    redirect_to @new_skill, notice: "New skill was successfully created."
  #  else
  #    render action: "new"
  #  end
  #end

  # PATCH/PUT /new_skills/1
  #def update
  #  if @new_skill.update(new_skill_params)
  #    redirect_to @new_skill, notice: "New skill was successfully updated."
  #  else
  #    render action: "edit"
  #  end
  #end

  # DELETE /new_skills/1
  #def destroy
  #  @new_skill.destroy
  #  redirect_to new_skills_url, notice: "New skill was successfully destroyed."
  #end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_new_skill
      @new_skill = NewSkill.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def new_skill_params
      params.require(:new_skill).permit(:skill_id)
    end
end
