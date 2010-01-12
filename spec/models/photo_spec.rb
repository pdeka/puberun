require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Photo do

    before(:each) do
        @valid_attributes = {:title => "my video name", :link => "my video ember object", :created_by => 10}
    end

    it "should create a new instance given valid attributes" do
        Photo.create!(@valid_attributes)
    end

    it "should convert flickr url to object embed" do
        my_attr = {:title => "my video name", :link => "http://flickr.com/photos/ramans/sets/1312014",
                :created_by => 10}
        my_photo = Photo.create!(my_attr)
        my_photo.link.should eql(my_photo.embedded_flickr("1312014"))

    end

    it "should convert flickr url to object embed with www in the url" do
        my_attr = {:title => "my photo name", :link => "http://www.flickr.com/photos/36929245@N02/sets/72157616075923593/",
                :created_by => 10}
        my_photo = Photo.create!(my_attr)
        my_photo.link.should eql(my_photo.embedded_flickr("72157616075923593"))

    end

    it "should not convert flickr url with something in the front of http" do
        my_attr = {:title => "my album name", :link => "<object>http://flickr.com/photos/ramans/sets/1312014",
                :created_by => 10}
        my_photo = Photo.create!(my_attr)
        my_photo.link.should eql("<object>http://flickr.com/photos/ramans/sets/1312014")
    end


    it "should convert picasa url to object embed" do
        my_attr = {:title => "my album name", :link => "http://picasaweb.google.com/prabindeka/Nothing#",
                :created_by => 10}
        my_photo = Photo.create!(my_attr)
        my_photo.link.should eql(my_photo.embedded_picasa("prabindeka", "Nothing"))
    end

    it "should not convert picasa url with something in the front of http" do
        my_attr = {:title => "my album name", :link => "<object>http://picasaweb.google.com/prabindeka/Nothing#",
                :created_by => 10}
        my_photo = Photo.create!(my_attr)
        my_photo.link.should eql("<object>http://picasaweb.google.com/prabindeka/Nothing#")
    end

    it "should convert picasa url with no # in the end" do
        my_attr = {:title => "my album name", :link => "http://picasaweb.google.com/prabindeka/Nothing",
                :created_by => 10}
        my_photo = Photo.create!(my_attr)
        my_photo.link.should eql(my_photo.embedded_picasa("prabindeka", "Nothing"))
    end

    it "should convert picasa url with a dot in the user name" do
        my_attr = {:title => "my album name", :link => "http://picasaweb.google.com/prabin.deka123/Nothing",
                :created_by => 10}
        my_photo = Photo.create!(my_attr)
        my_photo.link.should eql(my_photo.embedded_picasa("prabin.deka123", "Nothing"))
    end

    it "should convert flickr url to slideshow link" do
        my_attr = {:title => "my video name", :link => "asd",
                :slideshow => "http://flickr.com/photos/ramans/sets/1312014", :created_by => 10}
        my_photo = Photo.create!(my_attr)
        my_photo.slideshow.should eql(my_photo.flickr_slideshow("ramans", "1312014"))

    end

    it "should convert flickr url to slideshow url with www in the url" do
        my_attr = {:title => "my photo name", :link => "asd",
                :slideshow => "http://www.flickr.com/photos/36929245@N02/sets/72157616075923593/", :created_by => 10}
        my_photo = Photo.create!(my_attr)
        my_photo.slideshow.should eql(my_photo.flickr_slideshow("36929245@N02", "72157616075923593"))

    end

    it "should not convert flickr url with something in the front of http" do
        my_attr = {:title => "my album name", :link => "asd",
                :slideshow => "<object>http://flickr.com/photos/ramans/sets/1312014", :created_by => 10}
        my_photo = Photo.create!(my_attr)
        my_photo.slideshow.should eql("#")
    end

    it "should convert picasa url to slideshow url" do
        my_attr = {:title => "my album name", :link => "http://picasaweb.google.com/prabindeka/Nothing#",
                :slideshow => "http://picasaweb.google.com/prabindeka/Nothing#", :created_by => 10}
        my_photo = Photo.create!(my_attr)
        my_photo.slideshow.should eql(my_photo.picassa_slideshow("prabindeka", "Nothing"))
    end

    it "should have blank URL if its not flickr or picassa URL" do
        my_attr = {:title => "my album name", :link => "asdasda",
                :slideshow =>  "<object>http://picasaweb.google.com/prabindeka/Nothing#" , :created_by => 10}
        my_photo = Photo.create!(my_attr)
        my_photo.slideshow.should eql("#")
    end

    it "should convert picasa url to slideshow URL with no # in the end" do
        my_attr = {:title => "my album name", :link => "asdasd",
                :slideshow => "http://picasaweb.google.com/prabindeka/Nothing", :created_by => 10}
        my_photo = Photo.create!(my_attr)
        my_photo.slideshow.should eql(my_photo.picassa_slideshow("prabindeka", "Nothing"))
    end

    it "should convert picasa url to slideshow url with a dot in the user name" do
        my_attr = {:title => "my album name", :link => "asdasd",
                :slideshow => "http://picasaweb.google.com/prabin.deka123/Nothing", :created_by => 10}
        my_photo = Photo.create!(my_attr)
        my_photo.slideshow.should eql(my_photo.picassa_slideshow("prabin.deka123", "Nothing"))
    end


end

