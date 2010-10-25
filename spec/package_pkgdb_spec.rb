require File.expand_path(File.dirname(__FILE__) + '/spec_helper.rb')
require 'package'

describe 'Package::PkgdbInterface as  class' do
  it 'should be able to create a new Package::PkgdbInterface instance' do
    Package::PkgdbInterface.should respond_to(:new)
  end
end

describe 'Package::PkdgInterface' do 
  it 'should get the file from a remote url' 
  
  it 'should save the url'
 
  it 'should use a cached copy of the file unless the file is stale'
 
  it 'should invalidate the cache when stale'

   
end
