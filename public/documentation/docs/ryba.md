## Ryba                 

Ryba boostraps and manages a full secured Hadoop cluster with one command. This
is an [Open-source software (OSS) project][oss] released under the
[new BSD license][license] developed for one of the World largest utility
company. It is now operationnal.

## Motivations 

Ryba is our answer to DevOps integration need for product delivery and quality
testing. It provides the flexibilty to answer the demand of your internal 
information technology (IT) operations team. It is written in JavaScript and
CoffeeScript to facilitate and accelerate feature developments and maintenance 
releases. The language encourages self-documented code, look by yourself the
source code deploying two [HA namenodes][hdfs_nn].

Install Ryba locally or on a remote server and you are ready to go. It uses SSH
to connect to each server of your cluster and will fully install all the
components you wish. You don't need to prepare your cluster nodes as long as a
minimal installation of RHEL or CentOS is installed with a root user or a user
with sudo access.

-   Use secured comminication with SSH
-   No database used, full distribution across multiple servers relying on GIT
-   No agent or pre-installation required on your cluster nodes
-   Version control all your configuration and modifications (using GIT by default)
-   Command-based to integrate with your [Business Continuity Plan (BCP)][bcp] and existing scripts
-   For developer, as simple as learning Node.js and not a new framework
-   Self-documented code written in [Literate CoffeeScript ][literate]
-   Idempotent and executable on a running cluster without any negative impact

##  Features

-   Bootstrap the nodes from a fresh install
-   Configure proxy environment if needed
-   Optionnaly create a bind server (useful in Vagrant development environment)
-   Install OpenLDAP and Kerberos and/or integrate with your existing infrastructure
-   Deploy the latest Hortonworks Data Platform (HDP)
-   Setup High Availabity for HDFS
-   Integrate Kerberos with cross realm support
-   Set IPTables rules and startup scripts
-   Check the running components
-   Provide convenient utilities such as global start/stop/status commands, 
    distributed shell execution, ...


