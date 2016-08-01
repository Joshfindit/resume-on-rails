class ProfileItemsController < ApplicationController
  before_action :set_profile_item, only: [:show]

  # GET /profile_items
  def index
    @profile_items = ProfileItem.all
  end

  # GET /profile_items/1
  def show
  end

  # # GET /profile_items/new
  # def new
  #   @profile_item = ProfileItem.new
  # end

  # # GET /profile_items/1/edit
  # def edit
  # end

  # # POST /profile_items
  # def create
  #   @profile_item = ProfileItem.new(profile_item_params)

  #   if @profile_item.save
  #     redirect_to @profile_item, notice: 'Profile item was successfully created.'
  #   else
  #     render :new
  #   end
  # end

  # # PATCH/PUT /profile_items/1
  # def update
  #   if @profile_item.update(profile_item_params)
  #     redirect_to @profile_item, notice: 'Profile item was successfully updated.'
  #   else
  #     render :edit
  #   end
  # end

  # # DELETE /profile_items/1
  # def destroy
  #   @profile_item.destroy
  #   redirect_to profile_items_url, notice: 'Profile item was successfully destroyed.'
  # end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_profile_item
      @profile_item = ProfileItem.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def profile_item_params
                              
      params.require(:profile_item).permit( :name, :start_date, :end_date, :tags => [] )
    end
end
