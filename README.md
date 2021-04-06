# perforce2git-poc
This is a proof of concept of the migration of a Perforce depot to a git repository. It shows how a simple Perforce depot can be migrated
using [git-p4](https://git-scm.com/docs/git-p4). Note that this will import all branches defined with p4 branch that relate to the depot path specified in the 'git p4' command. 

# Prerequisites

- [VirtualBox](https://www.virtualbox.org/) (tested with 6.1.16)
- [Vagrant](https://www.vagrantup.com/intro) (tested with 2.2.9)

# Usage

Download or checkout this repo. Open a shell in the directory containing the file Vagrantfile and enter the command

    vagrant up

This will:

1. Create a VM with Ubuntu 20.04. 
2. Install Perforce server and p4 command line.
3. Fill the depot with a small amount of history: a couple of changes, a branche and a merge.
4. Migrate the main branch of the Perforce depot to a git repository.
5. Show the resulting git history.

This is all done in the inline script defined in the file Vagrantfile.

To play around with p4 and git within the VM:

    vagrant ssh
	
This will log in as the user vagrant. That user has both the Perforce cli and the git cli available.
