require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Music do

    before(:each) do
        @valid_attributes = {:title => "my music name", :link => "my music ember object",:music_type => "Song", :created_by => 10}
    end

    it "should create a new instance given valid attributes" do
        Music.create!(@valid_attributes)
    end

    it "should convert ovi url to embed" do
        my_attr = {:title => "my music name", :link => "http://share.ovi.com/media/pdeka.publicmedia/pdeka.10004", :created_by => 10, :music_type => "Song"}
        my_music = Music.create!(my_attr)
        my_music.link.should eql(my_music.embedded_ovi("pdeka.publicmedia","pdeka.10004"))
    end

    it "should convert ovi url to embed with another real url" do
        my_attr = {:title => "my music name", :link => "http://share.ovi.com/media/lizhaod.AGP2009-AlbertP/lizhaod.10581", :created_by => 10, :music_type => "Song"}
        my_music = Music.create!(my_attr)
        my_music.link.should eql(my_music.embedded_ovi("lizhaod.AGP2009-AlbertP","lizhaod.10581"))
    end

    it "should convert ovi url to embed with yet another real url" do
        my_attr = {:title => "my music name", :link => "http://share.ovi.com/media/dipudeka.shitshit2009/dipudeka.10002", :created_by => 10, :music_type => "Song"}
        my_music = Music.create!(my_attr)
        my_music.link.should eql(my_music.embedded_ovi("dipudeka.shitshit2009","dipudeka.10002"))
    end

end

