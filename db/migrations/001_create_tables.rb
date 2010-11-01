
class CreateTables < ActiveRecord::Migration
  def self.up
    create_table :packages do |t|
      t.column :name, :string, :null => false
      t.column :bugrl, :string
      t.column :gem_name, :string, :null => false
      t.column :kojiurl, :string
      t.column :upstream_version, :string
    end

    create_table :branches do |t|
      t.column :owner, :string
      t.column :comaint, :string
      t.column :branch, :string 
      t.column :provides, :string
      t.column :requires, :string
      t.column :specurl, :string
      t.column :version, :string
      t.column :repo, :string
    end
  end

  def self.down
    drop_table :packages
    drop_table :branches
  end

end
