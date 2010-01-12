#!/usr/local/bin/ruby

require 'net/http'
require 'rexml/document'
require 'rubygems'
require 'activerecord'

def parse_time string_time
    Time.zone = "Australia/Sydney"
    if string_time.nil? or string_time == ""
        Time.zone.now
    else
        Time.zone.parse(string_time)
    end
end




puts "running job to get sydney jaal content at - #{Time.now}" 
s = "Fri, 02 Oct 2008 01:49:49 GMT"
t = parse_time s
rs = t.strftime "%b %d, %Y, %I:%M:%S %p Sydney Time"
puts "Time string is #{s}"
puts "this is the time #{rs}"
puts "This is the zone #{t.zone}"
puts "This is the formatted string #{ t.strftime "%b %d, %Y, %I:%M:%S %p Sydney Time"}"
puts "---------------------------"
