require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get root_url
    assert_response :success
    assert_select "title", "Home - Surfriends"
  end

  test 'should get about' do
    get static_pages_about_url
    assert_response :success
    assert_select "title", "About - Surfriends"
  end

end
