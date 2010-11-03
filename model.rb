
begin
  require 'active_record'
rescue LoadError
  require "rubygems"
  require 'active_record'
end

class Package < ActiveRecord::Base
  has_many :branches
  validates_uniqueness_of :name
  
end

class Branch < ActiveRecord::Base
  belongs_to :package, :foreign_key => "package_id"
  validates_associated :package
  validates_uniqueness_of :branch, :scope =>  :package_id
end

