require 'spec_helper'

describe ItemsController do


  it_renders_404_page_when_item_is_not_found :show, :edit, :update, :destroy
  describe "show action" do

    it "renders show template if an item is found" do
      item = create(:item)
      get :show, {id: item.id}
      response.should render_template('show')
    end

    #it "renders 404 page if an items not found" do
    #  get :show, { id:0 }
    #  response.status.should == 404
    #end
  end

  describe "create action" do

    it "redirects to image cropping page if validation pass" do
      post :create, item:{name: 'Item 1', price: '10'}
      response.should render_template('crop_image')#redirect_to(crop_image_item_path(assigns(:item)))
    end

    it "renders new page again if validations fails" do
      post :create, item:{name: 'Item 1', price: nil}
      response. should render_template('new')
    end

  end

  describe "destroy action" do

    it "redirect to index action when an item is destroyed successfully" do
      item = create(:item)
      delete :destroy, id: item.id
      response.should redirect_to(items_path)
    end

    #it "render 404 page if ab item was not found" do
    #  delete :destroy, id: 0
    #  response.status.should == 404
    #end
  end

end