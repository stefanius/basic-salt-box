basic-salt-box
==============

Basic example of a Vagrant and Salt box.

Unfortunately the box is not perfectly. The Pillar data seems to be ignored when the box is started in 
single-server (masterless) mode in combination with Vagrant. The deletion of Apache2 and the start of Nginx 
as a service after the first provision isn't perfect either.

After checking out the project, you CD into the project folder. After that you type in the terminal the 
following commands after each other:

vagrant up
vagrant halt
vagrat up
vagrant provision

In the mean time you have to add the IP adress into your hosts-file.
