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
        lambda { Package.new('rubygem-rack') }.should_not raise_error(ArgumentError)
      end
 
      it 'should require a name' do
        lambda { Package.new }.should raise_error(ArgumentError)
      end
     
      it 'should return a Package instance' do
        Package.new('rubygem-rack').class.should == Package
      end
  end

  describe 'a package' do
      before(:each) do
        @pkg = Package.new('rubygem-rack')
      end

     it 'should have a gem name which is a string' do
       @pkg.gem_name.class.should == String 
     end

     it 'should have a gem name' do
       @pkg.gem_name.should == 'rack' 
     end
     
     it 'should have a gem name that is not equal to the package name' do
       @pkg.gem_name.should_not == @pkg.name
     end
     
     it 'should have an upstream version'  do 
       @pkg.upstream_version.should_not == nil
     end
   
     it 'should be an upstream version of 1.2.1 (for now)' do 
       @pkg.upstream_version.should == '1.2.1'
     end

     it 'should have a pkgdburl' do 
       @pkg.pkgdburl.should   =~ /http/i
     end
     
     it 'should have a pkgdburl that is a string' do
       @pkg.pkgdburl.class.should == String
     end

     it 'should have one or more branches' 
  
     it 'should have a devel branch' 

     #it 'should have a listing of bugs for the package' 

  end

  describe 'package branch' do 

    it 'should have a branch name' 
 
    it 'should have a package version in this branch' 

    it 'should have an owner in this branch' 

    it 'should have zero or more co-maintainers' 

    it 'should have a spec file URL in this branch' 
    
    # it 'should have an owner' do 
    #    @pkg.owner.should_not nil
     #end

    # it 'should be allowed to query owner' do
    #    @pkg.owner.should_not nil
     #end

    # it 'should not be allowed to set the owner' do 
    #    lambda { @pkg.owner =  'mrtesty' }.should raise_error(NoMethodError)
     #end
    
  end
end
