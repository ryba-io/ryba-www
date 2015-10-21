
# Start

The `./bin/ryba start` start the services of a cluster sequentially. Note, the
service must be correctly installed before running this command. Run
`./bin/ryba help start` for help.

```asciidoc
NAME
    masson start - Start server components
SYNOPSIS
    masson start [options...]
DESCRIPTION
    start               Start server components
      -h --hosts          Limit to a list of server hostnames
      -m --modules        Limit to a list of modules
      -f --fast           Fast mode without dependency resolution
```

Without any argument, the command start every service on every node.
Alternatively, the services can be started one by one. The commands
below list all the services in their expected/recommanded chronological order.
For each service, we provide the ryba command, the service command and native
command.

The `ryba` command is the recommanded practice. It present the advantage of
being executable from a single location as well as scheduling the startup
process between mulitple services. Ryba connect to each node over SSH and issue
the relevant startup commonds. Ryba garanty that a service is started in the
right sequential order after its dependencies are made available. 

The "service" command use the Unix service manager. SysV, installed on CentOS 6,
use the scripts located inside "/etc/init.d". This force you to log into the
server with SSH to issue the command.

The "native" command is also run from the server itself and references the
official Hadoop command.

## Zookeeper Server

Require: Krb5.

```bash
# Ryba
./bin/ryba start -m 'ryba/zookeeper/server'
# Service
service zookeeper-server start
# Native
su - zookeeper <<CMD
export ZOOCFGDIR=/usr/hdp/current/zookeeper-server/conf
export ZOOCFG=zoo.cfg
source /usr/hdp/current/zookeeper-server/conf/zookeeper-env.sh
/usr/hdp/current/zookeeper-server/bin/zkServer.sh start
CMD
```

## HDFS JournalNode

Require: ZooKeeper, Krb5.

```bash
# Ryba
./bin/ryba start -m 'ryba/hadoop/hdfs_jn'
# Service
service hadoop-hdfs-journalnode start
# Native
su -l hdfs <<CMD
/usr/hdp/current/hadoop-hdfs-journalnode/../hadoop/sbin/hadoop-daemon.sh \
  --config /etc/hadoop/conf \
  --script hdfs start journalnode
CMD
```

## HDFS DataNode

Require: ZooKeeper, Krb5.

```bash
# Ryba
./bin/ryba start -m 'ryba/hadoop/hdfs_dn'
# Service
service hadoop-hdfs-datanode start
# Native
su - hdfs <<CMD
HADOOP_SECURE_DN_USER=hdfs
/usr/hdp/current/hadoop-hdfs-datanode/../hadoop/sbin/hadoop-daemon.sh \
  --config /etc/hadoop/conf \
  --script hdfs start datanode
CMD
```

## HDFS NameNode

Require: HDFS JournalNode, HDFS DataNode, ZooKeeper, Krb5.

```bash
# Ryba
./bin/ryba start -m 'ryba/hadoop/hdfs_nn'
# Service
service hadoop-hdfs-namenode start
# Native
HADOOP_SECURE_DN_USER=hdfs
/usr/hdp/current/hadoop-hdfs-datanode/../hadoop/sbin/hadoop-daemon.sh \
  --config /etc/hadoop/conf \
  --script hdfs start datanode
```

## HDFS ZKFC

Require: HDFS NameNode, HDFS JournalNode, ZooKeeper, Krb5.

```bash
# Ryba
./bin/ryba start -m 'ryba/hadoop/zkfc'
# Service
service hadoop-hdfs-zkfc start
# Native
su - hdfs <<CMD
/usr/hdp/current/hadoop-client/sbin/hadoop-daemon.sh \
  --config /etc/hadoop/conf \
  --script hdfs start zkfc
CMD
```

## Mapreduce Job History Server

Require: HDFS, Krb5.

```bash
# Ryba
./bin/ryba start -m 'ryba/hadoop/mapred_jhs'
# Service
service hadoop-mapreduce-historyserver start
# Native
su - mapred <<CMD
export HADOOP_LIBEXEC_DIR=/usr/hdp/current/hadoop-client/libexec
/usr/hdp/current/hadoop-mapreduce-historyserver/sbin/mr-jobhistory-daemon.sh \
  --config /etc/hadoop/conf \
  start historyserver
CMD
```

## Yarn Application Timeline Server

Require: HDFS, Krb5.

```bash
# Ryba
./bin/ryba start -m 'ryba/hadoop/yarn_ts'
# Service
service hadoop-yarn-timelineserver start
# Native
su - yarn <<CMD
/usr/hdp/current/hadoop-yarn-timelineserver/sbin/yarn-daemon.sh \
  --config /etc/hadoop/conf \
  start timelineserver
CMD
```

## YARN NodeManager

Require: HFDS, Zookeeper, Krb5.

```bash
# Ryba
./bin/ryba start -m 'ryba/hadoop/yarn_nm'
# Service
service hadoop-yarn-nodemanager start
# Native
su - yarn <<CMD
export HADOOP_LIBEXEC_DIR=/usr/hdp/current/hadoop-client/libexec
/usr/hdp/current/hadoop-yarn-nodemanager/sbin/yarn-daemon.sh \
  --config /etc/hadoop/conf \
  start nodemanager
CMD
```

## YARN ResourceManager

Require: Yarn Timeline Server, MapReduce Job History Server, HFDS,
Zookeeper, Krb5.

```bash
# Ryba
./bin/ryba start -m 'ryba/hadoop/yarn_rm'
# Service
service hadoop-yarn-resourcemanager start
# Native
su - yarn <<CMD
export HADOOP_LIBEXEC_DIR=/usr/hdp/current/hadoop-client/libexec
/usr/lib/hadoop-yarn/sbin/yarn-daemon.sh \
  --config /etc/hadoop/conf \
  start resourcemanager
CMD
```

## HBase RegionServer

Require: HDFS, Zookeeper, Krb5.

```bash
# Ryba
./bin/ryba start -m 'ryba/hbase/regionserver'
# Service
service hbase-regionserver start
# Native
su - yarn <<CMD
export HADOOP_LIBEXEC_DIR=/usr/hdp/current/hadoop-client/libexec
/usr/lib/hadoop-yarn/sbin/yarn-daemon.sh \
  --config /etc/hadoop/conf \
  start resourcemanager
CMD
```

## HBase Master

Require: HDFS, Zookeeper, Krb5.

```bash
# Ryba
./bin/ryba start -m 'ryba/hbase/master'
# Service
service hbase-master start
# Native
su - hbase <<CMD
/usr/hdp/current/hbase-regionserver/bin/hbase-daemon.sh \
  --config /etc/hbase/conf \
  start master
CMD
```

## HBase REST Server

Require: HBase Master, HDFS, Zookeeper, Krb5.

```bash
# Ryba
./bin/ryba start -m 'ryba/hbase/rest'
# Service
service hbase-rest start
# Native
su - hbase <<CMD
/usr/hdp/current/hbase-client/bin/hbase-daemon.sh \
  --config /etc/hbase/conf \
  start rest
CMD
```

## Hive HCatalog/Metastore

Require: HDFS, Zookeeper, Krb5.

```bash
# Ryba
./bin/ryba start -m 'ryba/hive/hcatalog'
# Service
service hive-hcatalog-server start
# Native
su - hive <<CMD
nohup hive --service metastore \
  >/var/log/hive-hcatalog/hcat.out \
  2>/var/log/hive-hcatalog/hcat.err \
  &
echo $! >/var/lib/hive-hcatalog/hcat.pid
CMD
```

## Hive Server2

Require: Hive Hcatalog, HDFS, Zookeeper, Krb5.

```bash
# Ryba
./bin/ryba start -m 'ryba/hive/server2'
# Service
service hive-server2 start
# Native
su - hive <<CMD
nohup /usr/hdp/current/hive/bin/hiveserver2 \
  >/var/log/hive/hiveserver2.out \
  2>/var/log/hive/hiveserver2.log \
  &
echo $! >/var/run/hive/server2.pid
CMD
```

## Hive WebHCat

Require: Hive Hcatalog, HDFS, Zookeeper, Krb5.

```bash
# Ryba
./bin/ryba start -m 'ryba/hive/webhcat'
# Service
service hive-webhcat-server start
# Native
su - hive <<CMD
/usr/hdp/current/hive-webhcat/sbin/webhcat_server.sh start
CMD
```

## Oozie Server

Require: HBase, Hive, HDFS, Zookeeper, Krb5.

```bash
# Ryba
./bin/ryba start -m 'ryba/oozie/server'
# Service
# todo: service oozie start
# Native
su -l oozie -c "/usr/hdp/current/oozie-server/bin/oozied.sh start"
```

## Kafka Broker

Require: Zookeeper, Krb5.

```bash
# Ryba
./bin/ryba start -m 'ryba/kafka/broker'
# Service
# todo: service kafka-broker start
# Native
su - kafka <<CMD
/usr/hdp/current/kafka-broker/bin/kafka start
CMD
```

## Ganglia Collector

```bash
# Ryba
./bin/ryba start -m 'ryba/ganglia/collector'
# Service
service hdp-gmetad start
```

## Ganglia Monitor

```bash
# Ryba
./bin/ryba start -m 'ryba/ganglia/monitor'
# Service
service hdp-gmond start
```

## Nagios

```bash
# Ryba
./bin/ryba start -m 'ryba/nagios'
# Service
service nagios start
```
