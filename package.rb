

#module Package; end
require 'package_branch.rb'

class Package

  attr_reader :name, :branches, :pkgdburl, :gem_name, :upstream_version, :psearch

  def initialize(name)
    @name = name
    @gem_name = gem_name
    @pkgdburl = get_pkgdburl
    @upstream_version = get_upstream_version
    @branches = PackageBranchSearch.new(@name)
  end

  def get_pkgdburl
   "https://admin.fedoraproject.org/pkgdb/acls/name/#{@name}" 
  end

  def gem_name
    @name.gsub('rubygem-', '')
  end

  def gem_cache
    unless File.exists?('/tmp/gemlist')
      %x{gem list -r > /tmp/gemlist}
    end
  end

  def get_upstream_version
    gem_cache
    File.open('/tmp/gemlist').each do |line|
      next if line !~ /^#{@gem_name}\ /
         start = line.index '('
         stop = line.index ')'
         return line[start+1..stop-1]
    end
  end

end

