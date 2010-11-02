require 'rubygems'
require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'
require 'spec/rake/spectask'
require 'active_record'
require 'yaml'

#task :default => :migrate

desc "Migrate the database through scripts in db/migrate. Target specific version with VERSION=x"
task :migrate => :environment do
  ActiveRecord::Migrator.migrate('db/migrations', ENV["VERSION"] ? ENV["VERSION"].to_i : nil )
end

task :environment do
  sh "mkdir -p log; touch log/database.log"
  ActiveRecord::Base.establish_connection(YAML::load(File.open('config/database.yml')))
  ActiveRecord::Base.logger = Logger.new(File.open('log/database.log', 'a'))
end

desc 'Default: run specs.'
task :default => :spec

desc 'Test the linode library.'
Spec::Rake::SpecTask.new('spec') do |t|
  t.spec_files = FileList['spec/**/*_spec.rb']
end

desc 'Test the linode library.'
task :test => :spec
