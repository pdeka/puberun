require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/bihus/new.html.erb" do
  include BihusHelper
  
  before(:each) do
    assigns[:bihu] = stub_model(Bihu,
      :new_record? => true
    )
  end

  it "should render new form" do
    render "/bihus/new.html.erb"
    
    response.should have_tag("form[action=?][method=post]", bihus_path) do
    end
  end
end


