
class AddUpstreamUrl < ActiveRecord::Migration
  def self.up
    add_column :packages, :upstream_url, :string 
  end


  def self.down
     remove_column :packages, :upstream_url
  end

end
