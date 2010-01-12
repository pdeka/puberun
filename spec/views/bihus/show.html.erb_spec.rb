require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/bihus/show.html.erb" do
  include BihusHelper
  before(:each) do
    assigns[:bihu] = @bihu = stub_model(Bihu)
  end

  it "should render attributes in <p>" do
    render "/bihus/show.html.erb"
  end
end

