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
     
      it 'should return a Package instance' do
        Package.new('firefox').class.should == Package
      end
  end

  describe 'a package' do
      before(:each) do
        @pkg = Package.new('rubygem-rack')
      end

     it 'should have an owner' do 
        @pkg.owner.should_not nil
     end

     it 'should be allowed to query owner' do
        @pkg.owner.should_not nil
     end

     it 'should not be allowed to set the owner' do 
        lambda { @pkg.owner =  'mrtesty' }.should raise_error(NoMethodError)
     end

     it 'should have the an upstream version' 
   
     it 'should have one or more branches' 
  
     it 'should have one owner' 
  
     it 'should have a branch named rawhide' 

     it 'should have a listing of bugs for the package' 

     it 'should have a pkgdb url'

  end

  describe 'package branch' do 

    it 'should have a branch name' 
 
    it 'should have a package version in this branch' 

    it 'should have an owner in this branch' 

    it 'should have zero or more co-maintainers' 

    it 'should have a spec file URL' 
    
  end
end
