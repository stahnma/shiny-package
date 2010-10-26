require 'httparty'
require 'json'
require 'pp'

module Branch

  def get_branch(name)
    json_name = "/tmp/json-#{name}"
    get_branches(name, json_name)
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

  def get_json(name, json_name)
    url = "https://admin.fedoraproject.org/pkgdb/acls/name/#{name}?tg_format=json"
    response = HTTParty.get(url)
    json =  response.body
    File.open(json_name, 'w') do | f|
      f.write(json)
    end
  end

  def read_json(name, json_name)
    unless File.exists?(json_name)
      get_json(name, json_name)
    end
    json = IO.read(json_name)
    JSON.parse(json)
  end

  def get_branches(name, json_name)
    branches = []
    json = read_json(name, json_name)
    collections = json['packageListings']
    collections.each do | col|
      branches << col['collection']['branchname']
    end
    package = {}
    collections.each do | collection|
      comaint = []
      branch = collection['collection']['branchname']
      package[branch] = {}
      owner = collection['owner']
      collection['people'].each do | person | 
        if person['aclOrder']['commit']['statuscode'] ==  3 
        comaint << person['username']
      end 
    end
    if branch != nil 
      package[branch]['owner'] = owner 
        if comaint 
          begin
            comaint.delete(owner)
          rescue 
          end
          package[branch]['comaint'] = comaint.sort
        end 
        package[branch]['spec'] = get_spec_url(name, branch)
       end
    end
    return package
  end
end

#include Branch
#a = Branch.get_branch('rubygem-rake')
#pp a 

