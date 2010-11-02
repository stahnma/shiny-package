
class CreateTables < ActiveRecord::Migration
  def self.up
    create_table :packages do |t|
      t.column :name, :string, :null => false
      t.column :bug_url, :string
      t.column :gem_name, :string, :null => false
      t.column :koji_url, :string
      t.column :upstream_version, :string, :null => false
      t.timestamps
    end

    create_table :branches do |t|
      t.column :owner, :string, :null => false
      t.column :comaint, :string
      t.column :branch, :string, :null => false
      t.column :provides, :string
      t.column :requires, :string
      t.column :specurl, :string
      t.column :version, :string
      t.column :repo, :string
      t.timestamps
      t.references :package
    end
  end

  def self.down
    drop_table :packages
    drop_table :branches
  end

end
