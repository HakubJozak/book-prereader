require 'test_helper'

class WordsControllerTest < ActionDispatch::IntegrationTest
  test "should get update" do
    get words_update_url
    assert_response :success
  end

end
