#!/usr/bin/env ruby

require 'model'
require 'sinatra'
require 'package'
require 'erb'
require 'pp'

dbconfig = YAML::load(File.open(File.dirname(__FILE__) + '/config/database.yml'))
ActiveRecord::Base.logger = Logger.new(File.open('log/database.log', 'a'))
ActiveRecord::Base.establish_connection(dbconfig)

set :erb, :trim => '-'

get '/' do 
  @iter = [ 'devel', 'f14', 'f13', 'f12', 'el6', 'el5' ] 
  @packages = Package.find(:all, :order => "name" )
  puts @packages.class
  puts @packages.size
  erb :index
end
