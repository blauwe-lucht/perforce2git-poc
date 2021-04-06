$script = <<-SCRIPT
set -eo pipefail

#
# Install Perforce server and command line client
#
echo "deb http://package.perforce.com/apt/ubuntu bionic release" > /etc/apt/sources.list.d/perforce.list
wget -q http://package.perforce.com/perforce.pubkey -O- | sudo apt-key add -
apt-get update
apt-get install -y helix-p4d helix-cli
/opt/perforce/sbin/configure-helix-p4d.sh perforce -n -p tcp:localhost:1666 -r /perforce -u perforce -P "Abcd1234!"

#
# Set p4 client.
#
cat /vagrant/client.txt | sudo -u vagrant p4 client -i
sudo -u vagrant p4 sync
sudo -u vagrant mkdir /home/vagrant/depot

#
# Create some history.
#
sudo -u vagrant bash /vagrant/create_history.sh

#
# Install git-p4.
#
wget https://git.kernel.org/pub/scm/git/git.git/plain/git-p4.py?id=master -O /usr/bin/git-p4
chmod a+rx /usr/bin/git-p4
# On Ubuntu 20.04, python is not bound to python3 yet. The command below will make that happen.
apt-get install -y python-is-python3

#
# Clone the full Perforce repo into a new git repo.
#
sudo -u vagrant mkdir /home/vagrant/git
cd /home/vagrant/git
sudo -u vagrant git p4 clone --detect-branches //depot/project@all

#
# Show the result
#
cd /home/vagrant/git/project
sudo -u vagrant git log --graph --branches=* --remotes=*
SCRIPT

Vagrant.configure("2") do |config|
	config.vm.define "perforce" do |perforce|
		perforce.vm.box = "ubuntu/focal64"
		perforce.vm.hostname = "perforce"
		perforce.vm.network "private_network", ip: "192.168.34.112"
	end
	
	config.vm.provider "virtualbox" do |vb|
		vb.memory = "8192"
		vb.cpus = "2"
	end
	
	config.vm.provision "shell", inline: $script
end
