
begin
  require 'active_record'
rescue LoadError
  require "rubygems"
  require 'active_record'
end

class Package < ActiveRecord::Base
  has_many :branches
end

class Branch < ActiveRecord::Base
  belongs_to :package, :foreign_key => "package_id"
end

