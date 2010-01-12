require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe BillboardsController do

  def mock_billboard(stubs={})
    @mock_billboard ||= mock_model(Billboard, stubs)
  end
  
  describe "GET index" do

    it "exposes all billboards as @billboards" do
      Billboard.should_receive(:find).with(:all).and_return([mock_billboard])
      get :index
      assigns[:billboards].should == [mock_billboard]
    end

    describe "with mime type of xml" do
  
      it "renders all billboards as xml" do
        Billboard.should_receive(:find).with(:all).and_return(billboards = mock("Array of Billboards"))
        billboards.should_receive(:to_xml).and_return("generated XML")
        get :index, :format => 'xml'
        response.body.should == "generated XML"
      end
    
    end

  end

  describe "GET show" do

    it "exposes the requested billboard as @billboard" do
      Billboard.should_receive(:find).with("37").and_return(mock_billboard)
      get :show, :id => "37"
      assigns[:billboard].should equal(mock_billboard)
    end
    
    describe "with mime type of xml" do

      it "renders the requested billboard as xml" do
        Billboard.should_receive(:find).with("37").and_return(mock_billboard)
        mock_billboard.should_receive(:to_xml).and_return("generated XML")
        get :show, :id => "37", :format => 'xml'
        response.body.should == "generated XML"
      end

    end
    
  end

  describe "GET new" do
  
    it "exposes a new billboard as @billboard" do
      Billboard.should_receive(:new).and_return(mock_billboard)
      get :new
      assigns[:billboard].should equal(mock_billboard)
    end

  end

  describe "GET edit" do
  
    it "exposes the requested billboard as @billboard" do
      Billboard.should_receive(:find).with("37").and_return(mock_billboard)
      get :edit, :id => "37"
      assigns[:billboard].should equal(mock_billboard)
    end

  end

  describe "POST create" do

    describe "with valid params" do
      
      it "exposes a newly created billboard as @billboard" do
        Billboard.should_receive(:new).with({'these' => 'params'}).and_return(mock_billboard(:save => true))
        post :create, :billboard => {:these => 'params'}
        assigns(:billboard).should equal(mock_billboard)
      end

      it "redirects to the created billboard" do
        Billboard.stub!(:new).and_return(mock_billboard(:save => true))
        post :create, :billboard => {}
        response.should redirect_to(billboard_url(mock_billboard))
      end
      
    end
    
    describe "with invalid params" do

      it "exposes a newly created but unsaved billboard as @billboard" do
        Billboard.stub!(:new).with({'these' => 'params'}).and_return(mock_billboard(:save => false))
        post :create, :billboard => {:these => 'params'}
        assigns(:billboard).should equal(mock_billboard)
      end

      it "re-renders the 'new' template" do
        Billboard.stub!(:new).and_return(mock_billboard(:save => false))
        post :create, :billboard => {}
        response.should render_template('new')
      end
      
    end
    
  end

  describe "PUT udpate" do

    describe "with valid params" do

      it "updates the requested billboard" do
        Billboard.should_receive(:find).with("37").and_return(mock_billboard)
        mock_billboard.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :billboard => {:these => 'params'}
      end

      it "exposes the requested billboard as @billboard" do
        Billboard.stub!(:find).and_return(mock_billboard(:update_attributes => true))
        put :update, :id => "1"
        assigns(:billboard).should equal(mock_billboard)
      end

      it "redirects to the billboard" do
        Billboard.stub!(:find).and_return(mock_billboard(:update_attributes => true))
        put :update, :id => "1"
        response.should redirect_to(billboard_url(mock_billboard))
      end

    end
    
    describe "with invalid params" do

      it "updates the requested billboard" do
        Billboard.should_receive(:find).with("37").and_return(mock_billboard)
        mock_billboard.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :billboard => {:these => 'params'}
      end

      it "exposes the billboard as @billboard" do
        Billboard.stub!(:find).and_return(mock_billboard(:update_attributes => false))
        put :update, :id => "1"
        assigns(:billboard).should equal(mock_billboard)
      end

      it "re-renders the 'edit' template" do
        Billboard.stub!(:find).and_return(mock_billboard(:update_attributes => false))
        put :update, :id => "1"
        response.should render_template('edit')
      end

    end

  end

  describe "DELETE destroy" do

    it "destroys the requested billboard" do
      Billboard.should_receive(:find).with("37").and_return(mock_billboard)
      mock_billboard.should_receive(:destroy)
      delete :destroy, :id => "37"
    end
  
    it "redirects to the billboards list" do
      Billboard.stub!(:find).and_return(mock_billboard(:destroy => true))
      delete :destroy, :id => "1"
      response.should redirect_to(billboards_url)
    end

  end

end
