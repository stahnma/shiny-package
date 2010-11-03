require 'httparty'
require 'json'
require 'pp'

module BranchFill

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
    puts url
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
        puts "This is branch #{branch}"
      #  START HERE
          
        res = repo_info(name, branch) 
        if res.size > 0 
          package[branch]['version'] = res['version']
          package[branch]['provides'] = res['provides']
          package[branch]['repo'] = res['repo']
          package[branch]['requires'] = res['requires']
        end
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

    # Here we add repo info
    #puts "This is branch : #{package['branch']}"  
    #puts "In method get_branches: (#{name}, #{branch}) "
   # res = repo_info(name, branch) unless branch == nil
    #p res
    return package
  end

  def clean_branch_name(branch)
     branch.to_s.downcase.delete('-') unless branch == nil
  end

  def repo_info(name, branch)
   
    branch = clean_branch_name(branch)
    puts "In method repo_info: (#{name}, #{branch}) "
    result = {}
    enables = ""

    # TODO make this configurable
    File.open('repoquery.conf').each do |line|
      if line =~ /^\[#{branch}/
        token = line.split('[')[1].delete(']').strip
        enables << " --enablerepo=#{token}"
      end
    end

    base_command = "repoquery -c repoquery.conf #{enables} "
    ver_command = "#{base_command} --qf '%{version}-%{release}' #{name}"
    version = %x{#{ver_command}}.strip
    result['version'] = version
    req_command = "#{base_command} -q --requires #{name}"
    req = %x{#{req_command}}.gsub("\n", ", ").strip.chomp(',').split(',')
    req.map { |i| i.strip! } 
    result['requires'] = req
    prov_command = "#{base_command} --provides #{name}"
    prov = %x{#{prov_command}}.gsub("\n", ", ").strip.chomp(',').split(',')
    prov.map { |i| i.strip! } 
    result['provides'] = prov
    repo_command = "#{base_command} --qf '%{repoid}' #{name}"
    result['repo'] = %x{#{repo_command}}.strip!
    p result
    return result
 
  end

end
