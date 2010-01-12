require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/bihus/edit.html.erb" do
  include BihusHelper
  
  before(:each) do
    assigns[:bihu] = @bihu = stub_model(Bihu,
      :new_record? => false
    )
  end

  it "should render edit form" do
    render "/bihus/edit.html.erb"
    
    response.should have_tag("form[action=#{bihu_path(@bihu)}][method=post]") do
    end
  end
end


