#!/bin/bash
wget --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u45-b14/jdk-8u45-linux-x64.tar.gz
mkdir -p /usr/local/java
mv jdk-8u45-linux-x64.tar.gz /usr/local/java
cd /usr/local/java
tar -xf jdk-8u45-linux-x64.tar.gz
echo "JAVA_HOME=/usr/local/java/jdk1.8.0_45" >> /etc/profile
echo "JRE_HOME=/usr/local/java/jdk1.8.0_45/jre" >> /etc/profile
echo "PATH=\$PATH:\$JAVA_HOME/bin:\$JRE_HOME/bin" >> /etc/profile
echo "export JAVA_HOME" >> /etc/profile
echo "export JAVA_HOME" >> /etc/profile
echo "export PATH" >> /etc/profile
sh /etc/profile
update-alternatives --install "/usr/bin/java" "java" "/usr/local/java/jdk1.8.0_45/bin/java" 1 
update-alternatives --install "/usr/bin/javac" "javac" "/usr/local/java/jdk1.8.0_45/bin/javac" 1 
update-alternatives --install "/usr/bin/javaws" "javaws" "/usr/local/java/jdk1.8.0_45/bin/javaws" 1 
update-alternatives --set java /usr/local/java/jdk1.8.0_45/bin/java
update-alternatives --set javac /usr/local/java/jdk1.8.0_45/bin/javac
update-alternatives --set javaws /usr/local/java/jdk1.8.0_45/bin/javaws
rm -rf jdk-8u45-linux-x64.tar.gz
