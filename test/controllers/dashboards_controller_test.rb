require 'test_helper'

class DashboardsControllerTest < ActionDispatch::IntegrationTest
  test "should get synthesis" do
    get dashboards_synthesis_url
    assert_response :success
  end

  test "should get data-table" do
    get dashboards_data-table_url
    assert_response :success
  end

  test "should get profile" do
    get dashboards_profile_url
    assert_response :success
  end

end
