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

  describe 'as an instance' do
     before :all do
       
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

     it 'should have a listing of bugs for the package'  do 
        @pkg.bugurl.should_not == nil
        @pkg.bugurl.class.should == String
        @pkg.bugurl.should =~ /http/
     end

     it 'should have a url for koji builds '  do 
        @pkg.kojiurl.should_not == nil
        @pkg.kojiurl.class.should == String
        @pkg.kojiurl.should =~ /http/
     end


  end

  describe 'branch' do 
    before(:each) do 
      @pkg = Package.new('rubygem-rails')
      @pkg.fill_branch
      @branch = 'devel'
    end

    it 'should have one or more branches'  do
      @pkg.branches.size.should >= 0 
    end
 
    it 'should have a devel branch'  do 
      @pkg.branches.has_key?('devel').should == true
    end

    it 'should have a branch name'   do 
      @pkg.branches.keys.size.should > 0
    end
 
    it 'should have a package version in this branch'  

    it 'should have the koji tag for the version'

    it 'should have an owner in this branch' do 
       @pkg.branches[@branch]['owner'].should_not == nil
    end

    it 'should have an owner that is a string' do 
       @pkg.branches[@branch]['owner'].class.should == String
    end

    it 'should have an attribute co-maintainers'  do
       @pkg.branches[@branch]['comaint'].class.should == Array 
    end

    it 'should have zero or more co-maintainers'  do
       @pkg.branches[@branch]['comaint'].size >= 0 
    end

    it 'should have a spec file URL in this branch'  do 
       @pkg.branches[@branch]['spec'].should =~ /http:/
    end

    it 'should display Requires' 
  
    it 'should display BuildRequires'
 
    it 'should display Provides'
   
    it 'should have a source repo attribute' 

  end
end
