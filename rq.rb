#!/usr/bin/env ruby




#%x{koji latest-pkg #{tag} rubygem-rake | grep rubygem-rails"  } 




name = 'rubygem-rake'
dist = 'el5'

enables = ""
File.open('repoquery.conf').each do |line|
  if line =~ /^\[#{dist}/
    token = line.split('[')[1].delete(']').strip
    enables << " --enablerepo=#{token}"
  end
end

base_command = "repoquery -c repoquery.conf #{enables} "
ver_command = "#{base_command} --qf '%{version}-%{release}' #{name}"
version = %x{#{ver_command}}
req_command = "#{base_command} -q --requires #{name}"
req = %x{#{req_command}}.gsub("\n", ", ").strip.chomp(',').split(',')
req.map { |i| i.strip! } 
prov_command = "#{base_command} --provides #{name}"
prov = %x{#{prov_command}}.gsub("\n", ", ").strip.chomp(',').split(',')
prov.map { |i| i.strip! } 
repo_command = "#{base_command} --qf '%{repoid}' #{name}"
repo = %x{#{repo_command}}.strip!


puts  ver_command
puts version
p req
p prov
p repo

#foo = %x!repoquery -c repoquery.conf --enablerepo=epel5-testing --enablerepo=epel5-stable --enablerepo=centos5-base  --qf '%{version}-%{release}' rubygem-rake!
#puts foo
