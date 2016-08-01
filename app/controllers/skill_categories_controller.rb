class SkillCategoriesController < ApplicationController
  before_action :set_skill_category, only: [:show]

  # GET /skill_categories
  def index
    @skill_categories = SkillCategory.all.with_associations(:skills)
  end

  # GET /skill_categories/1
  def show
  end

  # # GET /skill_categories/new
  # def new
  #   @skill_category = SkillCategory.new
  # end

  # # GET /skill_categories/1/edit
  # def edit
  # end

  # # POST /skill_categories
  # def create
  #   @skill_category = SkillCategory.new(skill_category_params)

  #   if @skill_category.save
  #     redirect_to @skill_category, notice: 'Skill category was successfully created.'
  #   else
  #     render :new
  #   end
  # end

  # # PATCH/PUT /skill_categories/1
  # def update
  #   if @skill_category.update(skill_category_params)
  #     redirect_to @skill_category, notice: 'Skill category was successfully updated.'
  #   else
  #     render :edit
  #   end
  # end

  # # DELETE /skill_categories/1
  # def destroy
  #   @skill_category.destroy
  #   redirect_to skill_categories_url, notice: 'Skill category was successfully destroyed.'
  # end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_skill_category
      @skill_category = SkillCategory.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def skill_category_params
                              
      params.require(:skill_category).permit( :name, :skills => [] )
    end
end
