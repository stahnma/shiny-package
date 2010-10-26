require 'net/http'
require 'uri'
require 'httparty'
require 'json'
require 'pp'

def spec_url(name, branch)
  branch = branch.downcase
  branch = branch.gsub('-', '')
  if branch != 'devel'
    branch = branch + '/'
  else 
    branch = nil
  end
  "http://pkgs.fedoraproject.org/gitweb/?p=#{name}.git;a=blob_plain;f=#{name}.spec;hb=#{branch}master"
end

url = 'https://admin.fedoraproject.org/pkgdb/acls/name/rubygem-rails?tg_format=json'
uri = URI.parse(url)

#response = HTTParty.get(url)
#json =  response.body

#File.open('/tmp/json', 'w') do | f|
#  f.write(json)
#end

json = IO.read('/tmp/json')
a = JSON.parse(json )

branches = []
collections = a['packageListings']
collections.each do | col|
   branches << col['collection']['branchname']
end
puts branches

name = 'rubygem-rails'
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
   package[branch]['spec'] = spec_url(name, branch)
   end
end

pp package
