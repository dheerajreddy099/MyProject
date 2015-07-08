actions :create
default_action :create

attribute :username, :name_attribute => true, :kind_of => String, :required => true
attribute :secondary_groups, :kind_of => Array
attribute :password, :kind_of => String
attribute :home_directory, :kind_of => String
attribute :shell, :kind_of => String
attribute :authorized_keys, :kind_of => Array

attr_accessor :exists, :local, :uid, :primary_group
