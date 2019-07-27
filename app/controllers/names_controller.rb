class NamesController < ApplicationController
  include MyUtility
  before_action :set_name, only: [:show, :edit, :update, :destroy]

  # GET /names
  def index
    placeholder_set
    param_set
    @count	= Name.search(params[:q]).result.hit_count()
    @search	= Name.page(params[:page]).search(params[:q])
    @search.sorts = "id asc" if @search.sorts.empty?
    @names	= @search.result.per(50)
  end

  def param_set
    @form_params = {}
    
    params_clean(params)

    params_to_form(params, @form_params, column_name: "e_no", params_name: "e_no_form", type: "number")
    params_to_form(params, @form_params, column_name: "name", params_name: "name_form", type: "text")
    params_to_form(params, @form_params, column_name: "nickname", params_name: "nickname_form", type: "text")
  end
  # GET /names/1
  #def show
  #end

  # GET /names/new
  #def new
  #  @name = Name.new
  #end

  # GET /names/1/edit
  #def edit
  #end

  # POST /names
  #def create
  #  @name = Name.new(name_params)

  #  if @name.save
  #    redirect_to @name, notice: "Name was successfully created."
  #  else
  #    render action: "new"
  #  end
  #end

  # PATCH/PUT /names/1
  #def update
  #  if @name.update(name_params)
  #    redirect_to @name, notice: "Name was successfully updated."
  #  else
  #    render action: "edit"
  #  end
  #end

  # DELETE /names/1
  #def destroy
  #  @name.destroy
  #  redirect_to names_url, notice: "Name was successfully destroyed."
  #end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_name
      @name = Name.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def name_params
      params.require(:name).permit(:e_no, :name, :nickname)
    end
end
