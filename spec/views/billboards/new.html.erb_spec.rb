require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/billboards/new.html.erb" do
  include BillboardsHelper
  
  before(:each) do
    assigns[:billboard] = stub_model(Billboard,
      :new_record? => true,
      :title => "value for title",
      :body => "value for body"
    )
  end

  it "renders new billboard form" do
    render
    
    response.should have_tag("form[action=?][method=post]", billboards_path) do
      with_tag("input#billboard_title[name=?]", "billboard[title]")
      with_tag("textarea#billboard_body[name=?]", "billboard[body]")
    end
  end
end


