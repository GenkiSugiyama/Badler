require 'test_helper'

class ClubMenbersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get club_menbers_index_url
    assert_response :success
  end

  test "should get edit" do
    get club_menbers_edit_url
    assert_response :success
  end

  test "should get update" do
    get club_menbers_update_url
    assert_response :success
  end

end
