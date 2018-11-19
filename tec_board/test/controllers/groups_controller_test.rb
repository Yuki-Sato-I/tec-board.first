require 'test_helper'

class GroupsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get groups_index_url
    assert_response :success
  end

  test "should get board" do
    get groups_board_url
    assert_response :success
  end

  test "should get member" do
    get groups_member_url
    assert_response :success
  end

  test "should get picture" do
    get groups_picture_url
    assert_response :success
  end

  test "should get chat" do
    get groups_chat_url
    assert_response :success
  end

end
