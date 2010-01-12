require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/billboards/index.html.erb" do
  include BillboardsHelper
  
  before(:each) do
    assigns[:billboards] = [
      stub_model(Billboard,
        :title => "value for title",
        :body => "value for body"
      ),
      stub_model(Billboard,
        :title => "value for title",
        :body => "value for body"
      )
    ]
  end

  it "renders a list of billboards" do
    render
    response.should have_tag("tr>td", "value for title".to_s, 2)
    response.should have_tag("tr>td", "value for body".to_s, 2)
  end
end

