require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/billboards/show.html.erb" do
  include BillboardsHelper
  before(:each) do
    assigns[:billboard] = @billboard = stub_model(Billboard,
      :title => "value for title",
      :body => "value for body"
    )
  end

  it "renders attributes in <p>" do
    render
    response.should have_text(/value\ for\ title/)
    response.should have_text(/value\ for\ body/)
  end
end

