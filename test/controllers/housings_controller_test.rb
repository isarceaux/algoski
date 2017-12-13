require 'test_helper'

class HousingsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get housings_index_url
    assert_response :success
  end

end
