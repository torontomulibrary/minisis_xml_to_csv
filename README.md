Requirements
------------
* [ChefDK](https://downloads.chef.io/chef-dk/)
* [VirtualBox](https://www.virtualbox.org/)
* [Vagrant](https://vagrantup.com)
* vagrant-berkshelf plugin
* vagrant-omnibus plugin

## Usage
1. `git clone https://github.com/ryersonlibrary/minisis_xml_to_csv`
2. `cd minisis_xml_to_csv`
3. `vagrant install plugin vagrant-berkshelf` (skip if you already have this plugin installed)
4. `vagrant install plugin vagrant-omnibus` (skip if you already have this plugin installed)
5. `vagrant up && vagrant ssh`
6. `cd /vagrant/xml_to_csv && bundle`
7. `ruby xml_to_csv.rb`