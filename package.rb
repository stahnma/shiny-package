
class Package 
  attr_reader :name, :owner, :branch
  def initialize(name)
    @name = name
    @owner = 'michael'
    @branch = nil
  end
end

class Package::Branch
  def initialize(name)
  end
end

class Package::PkgdbInterface
   def initialize(name)
     @name = name
   end

   def remote_query
   end
   
   def stale?
   end

   
end
