
begin
  require 'active_record'
rescue LoadError
  require "rubygems"
  require 'active_record'
end

class Package < ActiveRecord::Base
  has_many :branches
  validates_uniqueness_of :name


  def try(br, id)
    puts "Finding by #{br} and #{id} "
    b = Branch.find_by_branch_and_package_id(br, id) 
    return b unless b.nil?
    if b.nil?
       br = br.upcase
       if br.index('-')
         return nil
       end
       pos = br.index(/[0-9]/)
       br =   br[0..pos-1] + '-' + br[pos..-1] if pos
    end
    Branch.find_by_branch_and_package_id(br, id)
  end


end

class Branch < ActiveRecord::Base
  belongs_to :package, :foreign_key => "package_id"
  validates_associated :package
  validates_uniqueness_of :branch, :scope =>  :package_id
end

