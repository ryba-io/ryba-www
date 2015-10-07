# Ryba's Internal Overview

## Module Perspective

Ryba is a Node.js good citizens.
When you start developing you must get the global overview of Ryba's internal.
Ryba aims at deploying Hadoop's components by ssh.
Components are chosen and configured by the user.
Ryba reads the configuration file and installs the components.

In Ryba's internal, each component is seen as a module (in the Node.js way).
So for example if you want to deploy Hbase thanks to ryba, you will have a Hbase
module which will contain all the code for deploying it.
Basically a Module is a physical folder named after the module's name.

## Commands

In Ryba's internal, each module has to implement commands in order to be
executed by Ryba. It works like a protocol. We know which command ryba can
execute. We declare the one we want to implements.
There are no compulsatory commands to implements.
Ryba can operate the following commands for modules.
Ryba answers to several commands :

  * install
  * start
  * status
  * stop
  * check
  * clean
  * backup

You are not compelled to develop the code for responding to each commands. It
depends of your needs only.
If you want to just install Hbase for example, you can just implement the
install command, then start the hbase daemons manually by connecting to each
server in the cluster.
That's the power of Ryba which is a flexible tool to answer your specific needs.

## Classical Use case

The classical use case is to answer the install, stop, start and check commands.
Some commands can be the union of other ones. For example Install command can
also execute start and check commands if you want.
We will see how it works exactly.

## What you need

We will need Node.js, Git, and NPM for installing and developping our own module.
We will also need a development cluster in order to test what we have developed.
You can refere to the [previous](/documentation/getting_started) section to
install a fast deployment server on your computer.




