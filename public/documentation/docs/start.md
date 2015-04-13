# Getting Started


## Introduction

Let's get Started in order to try Ryba !
The most simple way is to download the ryba-cluster package in addition to the ryba package. It comes with an ready to use configuration and can serve as an example.
The configuration comes with a ryba deployment which will set up a cluster composed of 6 nodes. 
Nothing to worry about each node  will take place in a virtual machine for the cluster to fit into your computer !

The following instructions will help you to install every needed tools :
* programs
* ryba packages
* configurations



These instructions presume that your host computer is connected to the Internet. You can find further instructions in the documentation to work offline. 


## Environnement

You can use any environnement you want , the given instructions are made for UNIX based OS' but you might find the equivalent tools for Windows.



## Install Git


You can either install it as a package, or download from source and compile it yourself

On linux systeme , you can install from you package manager by typing : `yum install git`  or `apt-get install git `( if you are on debian base systems).
On OSX or Windows, you can download the [Git installer](http://git-scm.com/download) available for your operating system.

## Install Node.js

Ryba is completely written in Node.js and is a app-like structure based software. We manage lot of resources and dependecies with npm ( in fact even some Ryba's packages dependecies has been written specially to be available on npm ).
To install Node.js, the recommended way is to use [n]( https://github.com/tj/n). If you are not familiar with Node.js, it would be easier to simply download the [Node.js installer](https://nodejs.org/download/) available for your operating system.

## Download the `ryba-cluster` starting package

It comes as mentioned above with a pre-configured cluster. Ryba is started from this package.
In order to get Ryba-cluster we recommend to git clone directly the repository, then to install the dependencies with a npm install.
Ryba is a Node.js good citizens. The more familiar you are with Node.js the faster you will understand Ryba internal operating way.
You can open  the package.json file to check the dependencies.

Run in a prompt

```
git clone https://github.com/ryba-io/ryba-cluster.git
cd ryba-cluster
npm install
```

## Get Familiar with the package

`ryba-cluster` package has been built to provide you suffisienteverythin to run ryba.
It wraps:

  * a "bin" folder
    - from this folder you can run vagrant, Ryba itself and manager your YUM local repositories.

  * a "conf" folder
    - this folder stores configuration files. The configurations files are modules that ryba will merge when it's launched.
  * node_modules
    - This is the folder managed by NPM. If you are not familiar with node.js, understand just that when you run npm install, NPM reads the dependecies from the package.json file, then download and install all the dependecies in the node_modules directory.

## Set UP and start your cluster

This step is to bootstrap  easily your cluster with Vagrant.
You can read about [Vagrant](www.vagrantup.com) if you are not familiar with it.
It's a easy-to-use software in order to manage Virtual Machine. juste describes the VM's properties ( Memory, processors, hosts adresses...) in the Vagrant's configuration file.
Vagrant will read the file and copy the fies needed and starts you VM.

The configuration file we provide uses  Vagrant to bootstrap a cluster of 6 nodes with a private network. You'll need 16GB of memory. It also register the server name and IP address inside you're "/etc/hosts" file. You can skip this step if you already have physical or virtual node at your disposal. Just modify the "conf/server.coffee" file to reflect your network topology.

## Run Ryba

Wait for you cluster and its configuration to be ready then make Ryba running to install, start and check your components is as simple as executing:

```
bin/ryba install
```

## Configure your host machine

On your host, you need declare the name and IP address of your cluster (if using Vagrant). You'll also need to import the Kerberos client configuration file.

```
sudo tee -a /etc/hosts << RYBA
10.10.10.11 master1.ryba
10.10.10.12 master2.ryba
10.10.10.13 master3.ryba
10.10.10.14 front1.ryba
10.10.10.16 worker1.ryba
10.10.10.17 worker2.ryba
10.10.10.18 worker3.ryba
RYBA
# Write "vagrant" as a password
# Be careful, this will overwrite your local krb5 file
scp vagrant@master1.ryba:/etc/krb5.conf /etc/krb5.conf
```

## Access the Hadoop Cluster web interfaces
You can read about [Kerberos](web.mit.edu/kerberos) if you are not familiar with it.
You host machine is now configured with Kerberos. From the command line, you shall be able to get a new ticket:
If you are note familiar with kerberos you can read about it 

```
echo hdfs123 | kinit hdfs@HADOOP.RYBA
klist
```

Most of the web applications started by Hadoop use [SPNEGO](spnego.sourceforge.net/index.html) to provide Kerberos authentication. SPNEGO isn't limited to Kerberos and is already supported by your favorite web browser. However, most of the browser (with the exception of Safari) need some specific configuration. Refer to the web to configure it or use `curl`:

```

curl -k --negotiate -u: https://master1.ryba:50470
```

You shall now be familiar with Ryba. Join us and participate to this project on [GitHub](https://github.com/ryba-io/ryba).