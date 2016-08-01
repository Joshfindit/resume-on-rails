require 'test_helper'

class VolunteerWorksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @volunteer_work = volunteer_works(:one)
  end

  test "should get index" do
    get volunteer_works_url
    assert_response :success
  end

  test "should get new" do
    get new_volunteer_work_url
    assert_response :success
  end

  test "should create volunteer_work" do
    assert_difference('VolunteerWork.count') do
      post volunteer_works_url, params: { volunteer_work: { city_id: @volunteer_work.city_id, company: @volunteer_work.company, dates_id: @volunteer_work.dates_id, name: @volunteer_work.name, province_id: @volunteer_work.province_id, skills_id: @volunteer_work.skills_id, tags_id: @volunteer_work.tags_id } }
    end

    assert_redirected_to volunteer_work_url(VolunteerWork.last)
  end

  test "should show volunteer_work" do
    get volunteer_work_url(@volunteer_work)
    assert_response :success
  end

  test "should get edit" do
    get edit_volunteer_work_url(@volunteer_work)
    assert_response :success
  end

  test "should update volunteer_work" do
    patch volunteer_work_url(@volunteer_work), params: { volunteer_work: { city_id: @volunteer_work.city_id, company: @volunteer_work.company, dates_id: @volunteer_work.dates_id, name: @volunteer_work.name, province_id: @volunteer_work.province_id, skills_id: @volunteer_work.skills_id, tags_id: @volunteer_work.tags_id } }
    assert_redirected_to volunteer_work_url(@volunteer_work)
  end

  test "should destroy volunteer_work" do
    assert_difference('VolunteerWork.count', -1) do
      delete volunteer_work_url(@volunteer_work)
    end

    assert_redirected_to volunteer_works_url
  end
end
