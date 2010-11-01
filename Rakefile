require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'
require 'spec/rake/spectask'
require 'active_record'
require 'yaml'

#task :default => :migrate

desc "Migrate the database through scripts in db/migrate. Target specific version with VERSION=x"
task :migrate => :environment do
  ActiveRecord::Migrator.migrate('db/migrate', ENV["VERSION"] ? ENV["VERSION"].to_i : nil )
end

task :environment do
  ActiveRecord::Base.establish_connection(YAML::load(File.open('database.yml')))
  ActiveRecord::Base.logger = Logger.new(File.open('database.log', 'a'))
end

desc 'Default: run specs.'
task :default => :spec

desc 'Test the linode library.'
Spec::Rake::SpecTask.new('spec') do |t|
  t.spec_files = FileList['spec/**/*_spec.rb']
end

desc 'Test the linode library.'
task :test => :spec

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gemspec|
    gemspec.name = "linode"
    gemspec.summary = "a Ruby wrapper for the Linode API"
    gemspec.description = "This is a wrapper around Linode's automation facilities."
    gemspec.email = "rick@rickbradley.com"
    gemspec.homepage = "http://github.com/rick/linode"
    gemspec.authors = ["Rick Bradley"]
    gemspec.add_dependency('httparty', '>= 0.4.4')
  end
  Jeweler::GemcutterTasks.new  
rescue LoadError
end

