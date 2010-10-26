
class Package 
  attr_reader :name, :branches, :pkgdburl, :gem_name, :upstream_version
  def initialize(name)
    @name = name
    @branches = nil
    @gem_name = gem_name
    @pkgdburl = get_pkgdburl
    @upstream_version = get_upstream_version
  end

  def get_pkgdburl
   "https://admin.fedoraproject.org/pkgdb/acls/name/#{@name}" 
  end

  def gem_name
    @name.gsub('rubygem-', '')
  end

  def gem_cached?
    File.stat('/tmp/gemlist')
  end

  def get_upstream_version
    if gem_cached? == false
      %x{gem list -r > /tmp/gemlist}
    end 
    File.open('/tmp/gemlist').each do |line|
      next if line !~ /^#{@gem_name}\ /
         start = line.index '('
         stop = line.index ')'
         return line[start+1..stop-1]
    end
  end
end

class Package::Branch
  def initialize(name)
  end
end
