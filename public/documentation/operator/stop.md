
# Stop

The `./bin/ryba stop` stop the services of a cluster sequentially.  Run
`./bin/ryba help stop` for help.

```asciidoc
./bin/ryba -c ./conf/env/offline.coffee help stop 
NAME
    masson stop - Stop server components
SYNOPSIS
    masson stop [options...]
DESCRIPTION
    stop                Stop server components
      -h --hosts          Limit to a list of server hostnames
      -m --modules        Limit to a list of modules
      -f --fast           Fast mode without dependency resolution
```

Without any argument, the command stop every service on every node.
Alternatively, the services can be stoped one by one. The commands
below list all the services in their expected/recommanded chronological order.

Consult the [starting] documentation for a description of the type of
command available. Note, the order in which services shall be stoped is the
exact reverse order in which they shall be started.

[starting]: /documentation/operator/start

## Nagios

```bash
# Ryba
./bin/ryba stop -m 'ryba/nagios'
# Service
service nagios stop
```

The file storing the PID is "/var/run/nagios.pid".

## Ganglia Monitor

```bash
# Ryba
./bin/ryba stop -m 'ryba/ganglia/monitor'
# Service
service hdp-gmond stop
```

The files storing the PIDs are "/var/run/ganglia/hdp/HDPHBaseMaster/gmond.pid",
"/var/run/ganglia/hdp/HDPHistoryServer/gmond.pid",  "/var/run/ganglia/hdp/HDPNameNode/gmond.pid",
"/var/run/ganglia/hdp/HDPResourceManager/gmond.pid" and "/var/run/ganglia/hdp/HDPSlaves/gmond.pid".

## Ganglia Collector

```bash
# Ryba
./bin/ryba stop -m 'ryba/ganglia/collector'
# Service
service hdp-gmetad stop
```

The files storing the PIDs are "/var/run/ganglia/hdp/gmetad.pid" and
"/var/run/ganglia/hdp/rrdcached.pid".

## Kafka Broker

```bash
# Ryba
./bin/ryba stop -m 'ryba/kafka/broker'
# Service
# todo: service kafka-broker stop
# Native
su - kafka <<CMD
/usr/hdp/current/kafka-broker/bin/kafka stop
CMD
```

The file storing the PID is "/var/run/kafka/kafka.pid".

## Oozie Server

```bash
# Ryba
./bin/ryba stop -m 'ryba/oozie/server'
# Service
# todo: service oozie stop
# Native
su - oozie <<CMD
/usr/hdp/current/oozie-server/bin/oozied.sh stop
CMD
```

The file storing the PID is "/var/run/oozie/oozie.pid".

## Hive WebHCat

```bash
# Ryba
./bin/ryba stop -m 'ryba/hive/webhcat'
# Service
service hive-webhcat-server stop
# Native
su - hive <<CMD
/usr/hdp/current/hive-webhcat/sbin/webhcat_server.sh stop
CMD
```

The file storing the PID is "/var/run/webhcat/webhcat.pid".

## Hive Server2

```bash
# Ryba
./bin/ryba stop -m 'ryba/hive/server2'
# Service
service hive-server2 stop
# Native
su - hive <<CMD
kill `cat /var/run/hive-server2/hive-server2.pid`
CMD
```

The file storing the PID is "/var/run/hive-server2/hive-server2.pid".

## Hive HCatalog/Metastore

```bash
# Ryba
./bin/ryba stop -m 'ryba/hive/hcatalog'
# Service
service hive-hcatalog-server stop
# Native
su - hive <<CMD
kill `cat /var/lib/hive-hcatalog/hcat.pid`
CMD
```

## HBase REST Server

```bash
# Ryba
./bin/ryba stop -m 'ryba/hbase/rest'
# Service
service hbase-rest stop
# Native
su - hbase <<CMD
/usr/hdp/current/hbase-client/bin/hbase-daemon.sh \
  --config /etc/hbase/conf \
  stop rest
CMD
```

The file storing the PID is "/var/run/hbase/hbase-hbase-rest.pid".

## HBase Master

```bash
# Ryba
./bin/ryba stop -m 'ryba/hbase/master'
# Service
service hbase-master stop
# Native
su - hbase <<CMD
/usr/hdp/current/hbase-regionserver/bin/hbase-daemon.sh \
  --config /etc/hbase/conf \
  stop regionserver
CMD
```

The file storing the PID is "/var/run/hbase/yarn/hbase-hbase-master.pid".

## HBase RegionServer

```bash
# Ryba
./bin/ryba stop -m 'ryba/hbase/regionserver'
# Service
service hbase-regionserver stop
# Native
su - hbase <<CMD
/usr/hdp/current/hbase-regionserver/bin/hbase-daemon.sh \
  --config /etc/hbase/conf \
  stop regionserver
CMD
```

The file storing the PID is "/var/run/hbase/yarn/hbase-hbase-regionserver.pid".

## YARN ResourceManager

```bash
# Ryba
./bin/ryba stop -m 'ryba/hadoop/yarn_rm'
# Service
service hadoop-yarn-resourcemanager stop
# Native
su - yarn <<CMD
/usr/lib/hadoop-yarn/sbin/yarn-daemon.sh \
  --config /etc/hadoop/conf \
  stop resourcemanager
CMD
```

The file storing the PID is "/var/run/hadoop-yarn/yarn/yarn-yarn-resourcemanager.pid".

## YARN NodeManager

```bash
# Ryba
./bin/ryba stop -m 'ryba/hadoop/yarn_nm'
# Service
service hadoop-yarn-nodemanager stop
# Native
su - yarn <<CMD
export HADOOP_LIBEXEC_DIR=/usr/lib/hadoop/libexec
/usr/lib/hadoop-yarn/sbin/yarn-daemon.sh \
  --config /etc/hadoop/conf \
  stop nodemanager
CMD
```

The file storing the PID is "/var/run/hadoop-yarn/yarn/yarn-yarn-nodemanager.pid".

## Yarn Application Timeline Server

```bash
# Ryba
./bin/ryba stop -m 'ryba/hadoop/yarn_ts'
# Service
service hadoop-yarn-timelineserver stop
# Native
su - yarn <<CMD
/usr/hdp/current/hadoop-yarn-timelineserver/sbin/yarn-daemon.sh \
  --config /etc/hadoop/conf \
  stop timelineserver
CMD
```

The file storing the PID is "/var/run/hadoop-yarn/yarn/yarn-yarn-timelineserver.pid".

## Mapreduce Job History Server

```bash
# Ryba
./bin/ryba stop -m 'ryba/hadoop/mapred_jhs'
# Service
service hadoop-mapreduce-historyserver stop
# Native
su - mapred <<CMD
export HADOOP_LIBEXEC_DIR=/usr/lib/hadoop/libexec
/usr/lib/hadoop-mapreduce/sbin/mr-jobhistory-daemon.sh \
  --config /etc/hadoop/conf \
  stop historyserver
CMD
```

The file storing the PID is "/var/run/hadoop-mapreduce/mapred-mapred-historyserver.pid".

## HDFS ZKFC

```bash
# Ryba
./bin/ryba stop -m 'ryba/hadoop/zkfc'
# Service
service hadoop-hdfs-zkfc stop
# Native
su - hdfs <<CMD
/usr/hdp/current/hadoop-client/sbin/hadoop-daemon.sh \
  --config /etc/hadoop/conf \
  --script hdfs \
  stop zkfc
CMD
```

## HDFS NameNode

```bash
# Ryba
./bin/ryba stop -m 'ryba/hadoop/hdfs_nn'
# Service
service hadoop-hdfs-namenode stop
# Native
su - hdfs <<CMD
/usr/hdp/current/hadoop-hdfs-namenode/../hadoop/sbin/hadoop-daemon.sh \
  --config /etc/hadoop/conf \
  --script hdfs \
  stop namenode
CMD
```

The file storing the PID is "/var/run/hadoop-hdfs/hadoop-hdfs-namenode.pid".

## HDFS DataNode

```bash
# Ryba
./bin/ryba stop -m 'ryba/hadoop/hdfs_dn'
# Service
service hadoop-hdfs-datanode stop
# Native
/usr/hdp/current/hadoop-hdfs-datanode/../hadoop/sbin/hadoop-daemon.sh \
  --config /etc/hadoop/conf \
  stop datanode
```

The file storing the PID is "/var/run/hadoop-hdfs/hadoop-hdfs-datanode.pid".

The file storing the PID is "/var/run/hadoop-hdfs/hadoop-hdfs-zkfc.pid".

## HDFS JournalNode

```bash
# Ryba
./bin/ryba stop -m 'ryba/hadoop/hdfs_jn'
# Service
service hadoop-hdfs-journalnode stop
# Native
su - hdfs <<CMD
/usr/hdp/current/hadoop-hdfs-journalnode/../hadoop/sbin/hadoop-daemon.sh \
  --config /etc/hadoop/conf \
  --script hdfs \
  stop journalnode
CMD
```

The file storing the PID is "/var/run/hadoop-hdfs/hadoop-hdfs-journalnode.pid".

## Zookeeper Server

```bash
# Ryba
./bin/ryba stop -m 'ryba/zookeeper/server'
# Service
service zookeeper-server stop
# Native
su - zookeeper <<CMD
export ZOOCFGDIR=/usr/hdp/current/zookeeper-server/conf
export ZOOCFG=zoo.cfg
source /usr/hdp/current/zookeeper-server/conf/zookeeper-env.sh
/usr/hdp/current/zookeeper-server/bin/zkServer.sh stop
CMD
```

The file storing the PID is "/var/run/zookeeper/zookeeper_server.pid".
