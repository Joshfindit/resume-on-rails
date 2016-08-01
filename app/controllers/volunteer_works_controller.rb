class VolunteerWorksController < ApplicationController
  before_action :set_volunteer_work, only: [:show]

  # GET /volunteer_works
  def index
    @volunteer_works = VolunteerWork.all.with_associations(:city, :province, :skills, :tags)
  end

  # GET /volunteer_works/1
  def show
  end

  # GET /volunteer_works/new
  # def new
  #   @volunteer_work = VolunteerWork.new
  # end

  # GET /volunteer_works/1/edit
  # def edit
  # end

  # # POST /volunteer_works
  # def create
  #   @volunteer_work = VolunteerWork.new(volunteer_work_params)

  #   if @volunteer_work.save
  #     redirect_to @volunteer_work, notice: 'Volunteer work was successfully created.'
  #   else
  #     render :new
  #   end
  # end

  # # PATCH/PUT /volunteer_works/1
  # def update
  #   if @volunteer_work.update(volunteer_work_params)
  #     redirect_to @volunteer_work, notice: 'Volunteer work was successfully updated.'
  #   else
  #     render :edit
  #   end
  # end

  # # DELETE /volunteer_works/1
  # def destroy
  #   redirect_to volunteer_works_url, notice: 'Destroy not allowed.'
  # end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_volunteer_work
    @volunteer_work = VolunteerWork.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def volunteer_work_params
                            
    params.require(:volunteer_work).permit( :name, :company, :dates => [], :city => [], :province => [], :skills => [], :tags => [] )
  end
end
