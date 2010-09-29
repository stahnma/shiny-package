require File.expand_path(File.dirname(__FILE__) + '/spec_helper.rb')
require 'package'

describe Package do
  describe 'as a class' do
    it 'should be able to create a new Package instance' do
        Package.should respond_to(:new)
    end
  end

  describe 'when creating a new Package instance' do
      it 'should accept a name argument' do
        lambda { Package.new('firefox') }.should_not raise_error(ArgumentError)
      end
 
      it 'should require a name' do
        lambda { Package.new }.should raise_error(ArgumentError)
      end
     
      it 'should return a Linode instance' do
        Package.new('firefox').class.should == Package
      end

  end
end
