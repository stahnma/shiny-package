#!/usr/bin/env ruby


require 'sinatra'
require 'package'
require 'erb'
require 'pp'


set :erb, :trim => '-'

get '/' do 
  @a = Package.new('rubygem-rails')
  @a.fill_branch
  pp @a
  erb :index
end
