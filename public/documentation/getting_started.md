# Getting Started


## Introduction

Let's dive into Ryba and bootstrap our first Hadoop Cluster. The most simple way
is to download the ryba-cluster package. It comes with a ready to use
configuration and can serve as a starting example.


The package deploys a cluster composed of 6 nodes. We use Vagrant to manage our
6 virtual machines. Running 6 virtual machines on the same developer machine
requires 16 GB of RAM. If you dont have enough resources on your machine, you
can use physical nodes or virtual machines at your disposal. This requires
to update the configuration to reflect the hostnames and IP addresses of those
servers.


These instructions presume that your host computer is connected to the Internet.
You can find further instructions in the documentation to work offline.

## Environnement

Ryba should work on any operating system. The given instructions are made for
UNIX based OS'. We only work on Linux and OSX but the tools we used are
all available on Windows.

## Install Git

You can either install it as a package, or download from source and compile it
yourself.

On linux systems, you can install from you package manager by typing : `yum
install git` or `apt-get install git` ( if you are on debian base systems).
On OSX or Windows, you can download the [Git installer](http://git-scm.com/download)
available for your operating system.

## Install Node.js

Ryba is written to run on the Node.js plateform. Dependencies are managed with
[NPM], the Node.js Package Manager.
To install Node.js, the recommended way is to use [n](https://github.com/tj/n).
If you are not familiar with Node.js, it would be easier to simply download the
[Node.js installer](https://nodejs.org/download/)
available for your operating system.

## Download the `ryba-cluster` starting package

It comes as mentioned above with a pre-configured cluster. Ryba is started from
this package. In order to get Ryba-cluster we recommend to git clone directly
the repository, then to install the dependencies run `npm install`. Ryba is a
Node.js good citizen. The more familiar you are with Node.js the faster you will
understand Ryba's internal operating way.
You can open the package.json file to check the dependencies.

Run in a prompt

```bash
git clone https://github.com/ryba-io/ryba-cluster.git
cd ryba-cluster
```

## Get Familiar with the package

`ryba-cluster` package has been prepared as a reference to run ryba. The project
layout contains the following files and folders

*   "bin"
    From this folder you can run vagrant, Ryba and manage your YUM local repositories.
*   "conf"
    This folder stores configuration files. The configurations files are modules that ryba will merge when it's launched.
*   "node_modules"
    This is the folder managed by NPM and used by Node.js to find it's dependencies.
*   "packages.json"
    A Node.js specific file which describe your project and its dependencies.

## Set UP and start your cluster

This step is to bootstrap easily your cluster with Vagrant.
You can read about [Vagrant](www.vagrantup.com) if you are not familiar with it.
It's an easy-to-use software to manage Virtual Machine. Just describe the VM's
properties (memory, processors, hosts adresses...) in Vagrant's configuration
file, it will then read it and copy the files needed and starts you VM.

The configuration file we provide uses Vagrant to bootstrap a cluster of 6 nodes
with a private network. You'll need 16GB of memory. It also registers the server
names and IP address inside your "/etc/hosts" file. You can skip this step if
you already have physical or virtual nodes at your disposal. Just modify the
"conf/server.coffee" file to reflect your network topology.

## Install Ryba

This section will download all your dependencies and leverages Node.js tools.
When you run `npm install`, NPM reads the names and versions of your
dependencies from the package.json file. It downloads and installs them inside
the node_modules directory.

```bash
npm install
```

## Run Ryba

Wait for your cluster and its configuration to be ready. Then, to make Ryba
install, start and check your components is as simple as executing:

```bash
bin/ryba install
```

## Configure your host machine

On your host, you need declare the name and IP addresses of your cluster (if
using Vagrant). You'll also need to import the Kerberos client configuration file.

```bash
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

You can read about [Kerberos](web.mit.edu/kerberos) if you are not familiar with
it. Your host machine is now configured with Kerberos. From the command line,
you shall be able to get a new ticket:

```bash
echo hdfs123 | kinit hdfs@HADOOP.RYBA
klist
```

Most of the web applications started by Hadoop use [SPNEGO](spnego.sourceforge.net/index.html)
to provide Kerberos authentication. SPNEGO isn't limited to Kerberos and is
already supported by your favorite web browser. However, most of the browsers
(with the exception of Safari) need some specific configuration. Refer to the
web to configure it or use `curl`:

```bash
curl -k --negotiate -u: https://master1.ryba:50470
```

You shall now be familiar with Ryba. Join us and participate to this project on
[GitHub](https://github.com/ryba-io/ryba).

[npm]: https://www.npmjs.com/
