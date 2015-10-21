
# Status

The `./bin/ryba status` print a message indicating if a service is running or
not. Run `./bin/ryba help install` for help.

```asciidoc
NAME
    masson status - Status of server components
SYNOPSIS
    masson status [options...]
DESCRIPTION
    status              Status of server components
      -h --hosts          Limit to a list of server hostnames
      -m --modules        Limit to a list of modules
      -f --fast           Fast mode without dependency resolution
```

Without any argument, the command print status information for every
service on every node.

## Zookeeper Server

```bash
# Ryba
./bin/ryba status -m 'ryba/zookeeper/server'
# Service
service zookeeper-server status
```

## HDFS JournalNode

```bash
# Ryba
./bin/ryba status -m 'ryba/hadoop/hdfs_jn'
# Service
service hadoop-hdfs-journalnode status
```

## HDFS DataNode

```bash
# Ryba
./bin/ryba status -m 'ryba/hadoop/hdfs_dn'
# Service
service hadoop-hdfs-datanode status
```

## HDFS NameNode

```bash
# Ryba
./bin/ryba status -m 'ryba/hadoop/hdfs_nn'
# Service
service hadoop-hdfs-namenode status
```

## HDFS ZKFC

```bash
# Ryba
./bin/ryba status -m 'ryba/hadoop/zkfc'
# Service
service hadoop-hdfs-zkfc status
```

## Mapreduce Job History Server

```bash
# Ryba
./bin/ryba status -m 'ryba/hadoop/mapred_jhs'
# Service
service hadoop-mapreduce-historyserver status
```

## Yarn Application Timeline Server

```bash
# Ryba
./bin/ryba status -m 'ryba/hadoop/yarn_ts'
# Service
service hadoop-yarn-timelineserver status
```

## YARN NodeManager

```bash
# Ryba
./bin/ryba status -m 'ryba/hadoop/yarn_nm'
# Service
service hadoop-yarn-nodemanager status
```

## YARN ResourceManager

```bash
# Ryba
./bin/ryba status -m 'ryba/hadoop/yarn_rm'
# Service
service hadoop-yarn-resourcemanager status
```

## HBase RegionServer

```bash
# Ryba
./bin/ryba status -m 'ryba/hbase/regionserver'
# Service
service hbase-regionserver status
```

## HBase Master

```bash
# Ryba
./bin/ryba status -m 'ryba/hbase/master'
# Service
service hbase-master status
```

## HBase REST Server

```bash
# Ryba
./bin/ryba status -m 'ryba/hbase/rest'
# Service
service hbase-rest status
```

## Hive HCatalog/Metastore

```bash
# Ryba
./bin/ryba status -m 'ryba/hive/hcatalog'
# Service
service hive-hcatalog-server status
```

## Hive Server2

```bash
# Ryba
./bin/ryba status -m 'ryba/hive/server2'
# Service
service hive-server2 status
```

## Hive WebHCat

```bash
# Ryba
./bin/ryba status -m 'ryba/hive/webhcat'
# Service
service hive-webhcat-server status
```

## Oozie Server

```bash
# Ryba
./bin/ryba status -m 'ryba/oozie/server'
# Service
# todo: service oozie status
# Native
su -l oozie -c "/usr/hdp/current/oozie-server/bin/oozied.sh status"
```

## Kafka Broker

```bash
# Ryba
./bin/ryba status -m 'ryba/kafka/broker'
# Service
# todo: service kafka-broker status
```

## Ganglia Collector

```bash
# Ryba
./bin/ryba status -m 'ryba/ganglia/collector'
# Service
service hdp-gmetad status
```

## Ganglia Monitor

```bash
# Ryba
./bin/ryba status -m 'ryba/ganglia/monitor'
# Service
service hdp-gmond status
```

## Nagios

```bash
# Ryba
./bin/ryba status -m 'ryba/nagios'
# Service
service nagios status
```
