require 'model'


    @@environment='development'
    @@dbconfig = YAML::load(File.open(File.dirname(__FILE__) + '/database.yml'))
    ActiveRecord::Base.establish_connection(@@dbconfig[@@environment])

