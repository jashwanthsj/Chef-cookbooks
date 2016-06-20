Nginx Cookbook
==============

· Install the nginx webserver via chef.

· Run a simple test using Vagrant's shell provisioner to ensure that nginx is listening on port 80

· Again, using configuration management, update contents of /etc/sudoers file so that Vagrant user can sudo without a password and that anyone in the admin group can sudo with a password.

· Make the solution idempotent so that re-running the provisioning step will not restart nginx unless changes have been made

· Create a simple "Hello World" web application in your favourite language of choice.

· Ensure your web application is available via the nginx instance.

· Extend the Vagrantfile to deploy this webapp to two additional vagrant machines and then configure the nginx to load balance between them.

· Test (in an automated fashion) that both app servers are working, and that the nginx is serving the content correctly.


-- Jashwanth S J
