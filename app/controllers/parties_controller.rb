class PartiesController < ApplicationController
  include MyUtility
  before_action :set_party, only: [:show, :edit, :update, :destroy]

  # GET /parties
  def index
    placeholder_set
    param_set
    @count	= Party.notnil_date().includes(:pc_name).ransack(params[:q]).result.hit_count()
    @search	= Party.notnil_date().includes(:pc_name).page(params[:page]).ransack(params[:q])
    @search.sorts = "id asc" if @search.sorts.empty?
    @parties	= @search.result.per(50)
  end

  def param_set
    @form_params = {}

    @latest_created = UploadedCheck.maximum("created_at")

    params_clean(params)
    if !params["is_form"] then
        #params["created_at_gteq_form"] ||= (@latest_created - 1.weeks).to_date.to_s
        params["created_at_lteq_form"] ||= @latest_created.to_date.to_s
    end

    params_to_form(params, @form_params, column_name: "pc_name_name", params_name: "pc_name_form", type: "text")
    params_to_form(params, @form_params, column_name: "ap_no", params_name: "ap_no_form", type: "number")
    params_to_form(params, @form_params, column_name: "e_no", params_name: "e_no_form", type: "number")
    params_to_form(params, @form_params, column_name: "party_order", params_name: "party_order_form", type: "number")
  end
  # GET /parties/1
  #def show
  #end

  # GET /parties/new
  #def new
  #  @party = Party.new
  #end

  # GET /parties/1/edit
  #def edit
  #end

  # POST /parties
  #def create
  #  @party = Party.new(party_params)

  #  if @party.save
  #    redirect_to @party, notice: "Party was successfully created."
  #  else
  #    render action: "new"
  #  end
  #end

  # PATCH/PUT /parties/1
  #def update
  #  if @party.update(party_params)
  #    redirect_to @party, notice: "Party was successfully updated."
  #  else
  #    render action: "edit"
  #  end
  #end

  # DELETE /parties/1
  #def destroy
  #  @party.destroy
  #  redirect_to parties_url, notice: "Party was successfully destroyed."
  #end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_party
      @party = Party.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def party_params
      params.require(:party).permit(:ap_no, :e_no, :party_order)
    end
end
