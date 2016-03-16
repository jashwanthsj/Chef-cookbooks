Install and configure ambari 2.0.0. Tested and supported on Ubuntu 12.04

1.Pass repo information through JSON.

2.Include `apt` cookbook into runlist along with `ambari-server-mysql-new` cookbook.

3.After launching ambari server, login to ambari server and go to `/root/.ssh/` location. Take the content of id_rsa.pub key which you need to pass in json of ambari agent layer. 

##############################################################################################################################
JSON for ambari server layer will be like,

```ruby
{
	"ambari-server-mysql-new": {
		"uri": "http://public-repo-1.hortonworks.com/ambari/ubuntu12/2.x/updates/2.0.0",
		"distribution": "Ambari",
		"keyserver": "hkp://keyserver.ubuntu.com:80",
		"key": "B9733A7A07513CAD",
        "dbhostname": "ambaridb1.cgrckkiyn7xn.us-west-2.rds.amazonaws.com",
        "dbname": "ambaridb",
        "dbusername": "ambariuser",
        "dbpasswd": "ambari123",
		"driver": "mysql-connector-java-5.1.38"
	}
}
```
##############################################################################################################################
