require 'net/http'
require 'uri'
require 'httparty'
require 'json'
require 'pp'

url = 'https://admin.fedoraproject.org/pkgdb/acls/name/rubygem-rails?tg_format=json'
uri = URI.parse(url)

#response = HTTParty.get(url)
#puts response.message
#json =  response.body


#File.open('/tmp/json', 'w') do | f|
#  f.write(json)
#end


def get_file_as_string(filename)                                                                                                
  data = ''                                                                                                                     
  f = File.open(filename, "r")                                                                                                  
  f.each_line do |line|                                                                                                         
    data += line                                                                                                                
  end                                                                                                                           
  return data                                                                                                                   
end  

json = get_file_as_string('/tmp/json')


a = JSON.parse(json )

#pp a['packageListings']


branches = []
collections = a['packageListings']
collections.each do | col|
   branches << col['collection']['branchname']
end
puts branches

#name->branch->owner
#name->branch->version
#name->branch->comaint

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
   end
end

pp package
#branches['collections'].each do |branch|
  #package[branch]['owner'] = collections['collection'][branch]
  #puts branch
#  puts branch.class
#  pp collections
  #pp collections[0]
  #pp collections['package']
#end

# Get a listing of possible branches 
#branches = a['packageListings']

   # Version 
   # Owner
   # Co-maint
   # Spec file url

#puts "
