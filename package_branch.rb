require 'httparty'
require 'json'
require 'pp'

#module Package; end

class PackageBranchSearch

#module Package::Branch; end

def initialize(name)
  @name = name
  @json_name = "/tmp/json-#{name}"
  @branches = get_branches
end

def size
  @branches.size
end

def has_key?(key)
  @branches.has_key?(key)
end

def build(name)
  @json_name = "/tmp/json-#{name}"
  @name = name
  branches = self.get_branches
  return branches
end

def get_spec_url(name, branch)
  branch = branch.downcase
  branch = branch.gsub('-', '')
  if branch != 'devel'
    branch = branch + '/'
  else 
    branch = nil
  end
  "http://pkgs.fedoraproject.org/gitweb/?p=#{name}.git;a=blob_plain;f=#{name}.spec;hb=#{branch}master"
end

def get_json
  url = "https://admin.fedoraproject.org/pkgdb/acls/name/#{name}?tg_format=json"
  response = HTTParty.get(url)
  json =  response.body
  File.open(@json_name, 'w') do | f|
    f.write(json)
  end
end

def read_json
  unless File.exists?(@json_name)
    get_json
  end
  json = IO.read(@json_name)
  JSON.parse(json)
end


def get_branches
branches = []
json = read_json
collections = json['packageListings']
collections.each do | col|
   branches << col['collection']['branchname']
end
#puts branches

package = {}
collections.each do | collection|
comaint = []
   #puts "Branch:" + collection['collection']['branchname']
   branch = collection['collection']['branchname']
   package[branch] = {}
   #puts "Owner: " +  collection['owner']
   owner = collection['owner']
   collection['people'].each do | person | 
     if person['aclOrder']['commit']['statuscode'] ==  3 
   #    puts "Co-maint: " + person['username'] 
       comaint << person['username']
     end 
   end
   if branch != nil 
   package[branch]['owner'] = owner 
   package[branch]['comaint'] = comaint.sort  if comaint
   package[branch]['spec'] = get_spec_url(@name, branch)
   end
end

return package
end

end


#a = PackageBranchSearch.new('rubygem-shoulda')
#pp a
