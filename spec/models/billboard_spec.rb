require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Billboard do
  before(:each) do
    @valid_attributes = {
      :title => "value for title",
      :body => "value for body"
    }
  end

  it "should create a new instance given valid attributes" do
    Billboard.create!(@valid_attributes)
  end
end
