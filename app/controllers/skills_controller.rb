class SkillsController < ApplicationController
  before_action :set_skill, only: [:show]

  # GET /skills
  def index
    @skills = Skill.all.with_associations(:jobs, :tags, :skill_category)
  end

  # GET /skills/1
  def show
  end

  # # GET /skills/new
  # def new
  #   @skill = Skill.new
  # end

  # # GET /skills/1/edit
  # def edit
  # end

  # # POST /skills
  # def create
  #   @skill = Skill.new(skill_params)

  #   if @skill.save
  #     redirect_to @skill, notice: 'Skill was successfully created.'
  #   else
  #     render :new
  #   end
  # end

  # # PATCH/PUT /skills/1
  # def update
  #   if @skill.update(skill_params)
  #     redirect_to @skill, notice: 'Skill was successfully updated.'
  #   else
  #     render :edit
  #   end
  # end

  # # DELETE /skills/1
  # def destroy
  #   @skill.destroy
  #   redirect_to skills_url, notice: 'Skill was successfully destroyed.'
  # end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_skill
      @skill = Skill.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def skill_params
                              
      params.require(:skill).permit( :name, :description, :tags => [], :skill_category => [] )
    end
end
