Enable passwordless login between ambari server and agents, also remove restriction to login as root user.

1.Enabling passwordless login between ambari server and agent servers.

For this, place hdp.pub key content in json of agent layer to update authorized keys file in all agent servers.

hdp.pub key will be there in ambari server /root/.ssh/ location.

2.Disable restriction for login as root user by removing first 155 characters in authorized keys. Recipe will take care of this step.


Json for ambari agent layer will be like,

##############################################################################################################################
JSON for ambari server layer will be like,

```ruby
{
        "ambari-agent": {
                "ambari-server-key": "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCofPz7rX/rUAVBbvfxUsPDL4ycKpfdZy5L+gtzF1mldNmHXTWUejkk3tZ8ztrvxp72iA6NUhlzuPZNcPoBy6yEDaNJRCz5MfsXAQ8zt8pFTbaNilVx3S4vnE9YJZjyRahNqmBShmHNqBdNYbFRG31pppd1q04To5FxkZq58eOBN6dzTDXTUKilAQwF9NctW9tikZqX9lI70DBYxlnvAVcK8EdX0hl/+KIMsgJtgIfvxkTf57Cv2cw+ugcafigmW/hPJjClo5w2RGLp2ETY9fsyeWxKeHH+zDkj+YqXr2owKeP0CSAgQppX6Jlb6AE4KYzZ0WkH8TT8n94UnXEvZmQj root@ambari-server-mysql"
        }
}
```
##############################################################################################################################
