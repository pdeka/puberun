require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/billboards/edit.html.erb" do
  include BillboardsHelper
  
  before(:each) do
    assigns[:billboard] = @billboard = stub_model(Billboard,
      :new_record? => false,
      :title => "value for title",
      :body => "value for body"
    )
  end

  it "renders the edit billboard form" do
    render
    
    response.should have_tag("form[action=#{billboard_path(@billboard)}][method=post]") do
      with_tag('input#billboard_title[name=?]', "billboard[title]")
      with_tag('textarea#billboard_body[name=?]', "billboard[body]")
    end
  end
end


