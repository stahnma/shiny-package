require 'model'
require 'package'
require 'pp'

dbconfig = YAML::load(File.open(File.dirname(__FILE__) + '/config/database.yml'))
ActiveRecord::Base.logger = Logger.new(File.open('log/database.log', 'a'))
ActiveRecord::Base.establish_connection(dbconfig)


#name = 'rubygem-rails'


def do_the_needful(name)
a = PackageFill.new(name)
h = Package.find_by_name(name)
unless h
  h = Package.new
end
h.bug_url = a.bugurl
h.koji_url = a.kojiurl
h.name = a.name
h.gem_name = a.gem_name
h.pkgdb_url = a.pkgdburl
h.upstream_version = a.upstream_version
h.upstream_url = a.upstream_url
h.save!

a.fill_branch
id = Package.find_by_name(name).id
p a.branches
p a.branches.class
a.branches.each_key do |key| 
  puts "Working with key #{key}"
  # First look to see if I can find existing branch of package
  b = Branch.find_by_package_id_and_branch(id, key)
  unless  b 
    b = Branch.new 
  end
  
  b.branch = key 
  hsh = a.branches[key]
  b.repo = hsh['repo'].to_s
  b.provides = hsh['provides'].join('^') if hsh['provides'].is_a?(Array)
  b.requires = hsh['requires'].join('^') if hsh['requires'].is_a?(Array)
  puts "Setting version #{hsh['version'].to_s}"
  b.version = hsh['version'].to_s
  b.owner = hsh['owner'].to_s
  b.comaint = hsh['comaint'].join('^') if hsh['comint'].is_a?(Array)
  b.package_id = id 
  b.save! 
end


end


names = [ 'rubygem-RedCloth'  ]

names.each do | name|
  do_the_needful(name)
end
