class UploadedChecksController < ApplicationController
  include MyUtility
  before_action :set_uploaded_check, only: [:show, :edit, :update, :destroy]

  # GET /uploaded_checks
  def index
    placeholder_set
    param_set
    @count	= UploadedCheck.search(params[:q]).result.hit_count()
    @search	= UploadedCheck.page(params[:page]).search(params[:q])
    @search.sorts = "id asc" if @search.sorts.empty?
    @uploaded_checks	= @search.result.per(50)
  end

  def param_set
    @form_params = {}

    params_clean(params)

    params_to_form(params, @form_params, column_name: "pc_name_name", params_name: "pc_name_form", type: "text")
  end
  # GET /uploaded_checks/1
  #def show
  #end

  # GET /uploaded_checks/new
  #def new
  #  @uploaded_check = UploadedCheck.new
  #end

  # GET /uploaded_checks/1/edit
  #def edit
  #end

  # POST /uploaded_checks
  #def create
  #  @uploaded_check = UploadedCheck.new(uploaded_check_params)

  #  if @uploaded_check.save
  #    redirect_to @uploaded_check, notice: "Uploaded check was successfully created."
  #  else
  #    render action: "new"
  #  end
  #end

  # PATCH/PUT /uploaded_checks/1
  #def update
  #  if @uploaded_check.update(uploaded_check_params)
  #    redirect_to @uploaded_check, notice: "Uploaded check was successfully updated."
  #  else
  #    render action: "edit"
  #  end
  #end

  # DELETE /uploaded_checks/1
  #def destroy
  #  @uploaded_check.destroy
  #  redirect_to uploaded_checks_url, notice: "Uploaded check was successfully destroyed."
  #end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_uploaded_check
      @uploaded_check = UploadedCheck.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def uploaded_check_params
      params[:uploaded_check]
    end
end
