class TypeNamesController < ApplicationController
  include MyUtility
  before_action :set_type_name, only: [:show, :edit, :update, :destroy]

  # GET /type_names
  def index
    placeholder_set
    param_set
    @count	= TypeName.ransack(params[:q]).result.hit_count()
    @search	= TypeName.page(params[:page]).ransack(params[:q])
    @search.sorts = "id asc" if @search.sorts.empty?
    @type_names	= @search.result.per(50)
  end

  def param_set
    @form_params = {}

    params_clean(params)

    params_to_form(params, @form_params, column_name: "type_id", params_name: "type_id_form", type: "number")
    params_to_form(params, @form_params, column_name: "name", params_name: "name_form", type: "number")
  end
  # GET /type_names/1
  #def show
  #end

  # GET /type_names/new
  #def new
  #  @type_name = TypeName.new
  #end

  # GET /type_names/1/edit
  #def edit
  #end

  # POST /type_names
  #def create
  #  @type_name = TypeName.new(type_name_params)

  #  if @type_name.save
  #    redirect_to @type_name, notice: "Type name was successfully created."
  #  else
  #    render action: "new"
  #  end
  #end

  # PATCH/PUT /type_names/1
  #def update
  #  if @type_name.update(type_name_params)
  #    redirect_to @type_name, notice: "Type name was successfully updated."
  #  else
  #    render action: "edit"
  #  end
  #end

  # DELETE /type_names/1
  #def destroy
  #  @type_name.destroy
  #  redirect_to type_names_url, notice: "Type name was successfully destroyed."
  #end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_type_name
      @type_name = TypeName.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def type_name_params
      params.require(:type_name).permit(:type_id, :name)
    end
end
