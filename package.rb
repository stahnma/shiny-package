
class Package 
  attr :owner
  def initialize(name)
    @name = name
    @owner = 'michael'
  end
end


class Package::Branch
  def initialize(name)
  end

  

  def getOwner
    File.open('format1.txt').each do |line|
      line.strip!
      if line[@name] != nil
        if line['Fedora EPEL|']
          @epelmaint = line.split('|')[3]
          begin
            @epelco = line.split('|')[5].split(',')
          rescue
            @epelco = nil
          end
        elsif line['Fedora|']
          @maint = line.split('|')[3]
          begin
            @co = line.split('|')[5].split(',')
          rescue
            @co = nil
          end
        end
      end
    end
  end

  
end


class Package::PkgdbInterface
   def initialize(name)
     @name = name
   end
end
