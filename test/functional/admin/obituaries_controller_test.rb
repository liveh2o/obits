require 'test_helper'

class Admin::ObituariesControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end

  def test_show
    get :show, :id => Obituary.first
    assert_template 'show'
  end

  def test_new
    get :new
    assert_template 'new'
  end

  def test_create_invalid
    Obituary.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end

  def test_create_valid
    Obituary.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to admin_obituary_url(assigns(:obituary))
  end

  def test_edit
    get :edit, :id => Obituary.first
    assert_template 'edit'
  end

  def test_update_invalid
    Obituary.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Obituary.first
    assert_template 'edit'
  end

  def test_update_valid
    Obituary.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Obituary.first
    assert_redirected_to admin_obituary_url(assigns(:obituary))
  end

  def test_destroy
    obituary = Obituary.first
    delete :destroy, :id => obituary
    assert_redirected_to admin_obituaries_url
    assert !Obituary.exists?(obituary.id)
  end
end
