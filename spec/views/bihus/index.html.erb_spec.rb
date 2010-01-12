require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/bihus/index.html.erb" do
  include BihusHelper
  
  before(:each) do
    assigns[:bihus] = [
      stub_model(Bihu),
      stub_model(Bihu)
    ]
  end

  it "should render list of bihus" do
    render "/bihus/index.html.erb"
  end
end

