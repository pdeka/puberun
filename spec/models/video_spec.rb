require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Video do
    before(:each) do
        @valid_attributes = {:title => "my video name", :link => "my video ember object", :created_by => 10}
    end

    it "should create a new instance given valid attributes" do
        Video.create!(@valid_attributes)
    end

    it "should convert au youtube url to object embed" do
        my_attr = {:title => "my video name", :link => "http://au.youtube.com/watch?v=SuugciKjhPY", :created_by => 10}
        my_video = Video.create!(my_attr)
        my_video.link.should eql(my_video.embedded_youtube("SuugciKjhPY"))

    end

    it "should convert generic youtube url to object embed" do
        my_attr = {:title => "my video name", :link => "http://www.youtube.com/watch?v=SuugciKjhPY", :created_by => 10}
        my_video = Video.create!(my_attr)
        my_video.link.should eql(my_video.embedded_youtube("SuugciKjhPY"))
    end

end

