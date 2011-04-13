require 'test_helper'

class ObituariesControllerTest < ActionController::TestCase
  setup do
    @obituary = obituaries(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:obituaries)
  end
end
