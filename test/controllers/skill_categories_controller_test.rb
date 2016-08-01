require 'test_helper'

class SkillCategoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @skill_category = skill_categories(:one)
  end

  test "should get index" do
    get skill_categories_url
    assert_response :success
  end

  test "should get new" do
    get new_skill_category_url
    assert_response :success
  end

  test "should create skill_category" do
    assert_difference('SkillCategory.count') do
      post skill_categories_url, params: { skill_category: { name: @skill_category.name, skills_id: @skill_category.skills_id } }
    end

    assert_redirected_to skill_category_url(SkillCategory.last)
  end

  test "should show skill_category" do
    get skill_category_url(@skill_category)
    assert_response :success
  end

  test "should get edit" do
    get edit_skill_category_url(@skill_category)
    assert_response :success
  end

  test "should update skill_category" do
    patch skill_category_url(@skill_category), params: { skill_category: { name: @skill_category.name, skills_id: @skill_category.skills_id } }
    assert_redirected_to skill_category_url(@skill_category)
  end

  test "should destroy skill_category" do
    assert_difference('SkillCategory.count', -1) do
      delete skill_category_url(@skill_category)
    end

    assert_redirected_to skill_categories_url
  end
end
