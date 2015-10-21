
# Guide for operators

The command `./bin/ryba` is used to install, start, stop and report status
inside the cluster. Without any arguments, it applies to all modules. It can
also filter by modules with the "-m" or "--modules" parameter.

For example, use the following command to start the ZooKeeper, HDFS and YARN
related services: `./bin/ryba start -m 'ryba/zookeeper/*' -m 'ryba/hadoop/**'`

Run "./bin/ryba help" for detailed information.

*   [Installing](/documentation/operator/install)
*   [Starting](/documentation/operator/start)
*   [Stoping](/documentation/operator/stop)
*   [Status](/documentation/operator/status)
