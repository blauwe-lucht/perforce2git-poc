#!/bin/bash
set -eo pipefail

p4_submit () {
  CL=`p4 changes -s pending -m 1 | cut -d ' ' -f 2`
  p4 submit -c $CL
}

mkdir -p /home/vagrant/depot/project/main
echo "Hello world" > /home/vagrant/depot/project/main/test.txt
p4 add /home/vagrant/depot/project/main/test.txt
p4 change -o | sed 's/<enter description here>/Initial commit./g' | p4 change -i
p4_submit

p4 edit /home/vagrant/depot/project/main/test.txt
echo "How are you?" >> /home/vagrant/depot/project/main/test.txt
p4 change -o | sed 's/<enter description here>/Add extra line./g' | p4 change -i
p4_submit

cat /vagrant/branch.txt | p4 branch -i
p4 integrate -b some_branch
p4 change -o | sed 's/<enter description here>/Create branch./g' | p4 change -i
p4_submit

p4 edit /home/vagrant/depot/project/some_branch/test.txt
echo "This line is an experiment." >> /home/vagrant/depot/project/some_branch/test.txt
p4 change -o | sed 's/<enter description here>/Experiment./g' | p4 change -i
p4_submit

p4 integrate //depot/project/some_branch/test.txt //depot/project/main/test.txt
p4 resolve -a
p4 change -o | sed 's/<enter description here>/Merging./g' | p4 change -i
p4_submit
