# perforce2git-poc
Proof of concept of a migration of a Perforce depot to a git repository. It shows how a simple Perforce depot can be migrated
using git-p4. Note that it will only migrate a single branch (the main branch). I haven't found a way to do this
for multiple branches.

# Prerequisites

- VirtualBox (tested with 6.1.16)
- Vagrant (tested with 2.2.9)

# Usage

    vagrant up

This will:

1. Create a VM with Ubuntu 20.04. 
2. Install Perforce server and cli.
3. Fill the depot with a small amount of history; a couple of changes, a branche and a merge.
4. Migrate the main branch of the Perforce depot to a git repository.
5. Show the resulting history.

This is all done in the inline script defined in the file Vagrantfile.
