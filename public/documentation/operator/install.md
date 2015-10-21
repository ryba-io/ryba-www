
# Install

The `./bin/ryba install` deploy, configure and start the services of a cluster
sequentially. Run `./bin/ryba help install` for help.

```asciidoc
NAME
    masson install - Install components and deploy configuration
SYNOPSIS
    masson install [options...]
DESCRIPTION
    install             Install components and deploy configuration
      -h --hosts          Limit to a list of server hostnames
      -m --modules        Limit to a list of modules
      -f --fast           Fast mode without dependency resolution
```

Without any argument, the command start every service on every node.

## Zookeeper Server

```bash
./bin/ryba install -m 'ryba/zookeeper/server'
```

## HDFS JournalNode

```bash
./bin/ryba install -m 'ryba/hadoop/hdfs_jn'
```

## HDFS ZKFC

```bash
./bin/ryba install -m 'ryba/hadoop/zkfc'
```

## HDFS DataNode

```bash
./bin/ryba install -m 'ryba/hadoop/hdfs_dn'
```

## HDFS NameNode

```bash
./bin/ryba install -m 'ryba/hadoop/hdfs_nn'
```

## Mapreduce Job History Server

```bash
./bin/ryba install -m 'ryba/hadoop/mapred_jhs'
```

## Yarn Application Timeline Server

```bash
./bin/ryba install -m 'ryba/hadoop/yarn_ts'
```

## YARN NodeManager

```bash
./bin/ryba install -m 'ryba/hadoop/yarn_nm'
```

## YARN ResourceManager

```bash
./bin/ryba install -m 'ryba/hadoop/yarn_rm'
```

## HBase RegionServer

```bash
./bin/ryba install -m 'ryba/hbase/regionserver'
```

## HBase Master

```bash
./bin/ryba install -m 'ryba/hbase/master'
```

## HBase REST Server

```bash
./bin/ryba install -m 'ryba/hbase/rest'
```

## Hive HCatalog/Metastore

```bash
./bin/ryba install -m 'ryba/hive/hcatalog'
```

## Hive Server2

```bash
./bin/ryba install -m 'ryba/hive/server2'
```

## Hive WebHCat

```bash
./bin/ryba install -m 'ryba/hive/webhcat'
```

## Oozie Server

```bash
./bin/ryba install -m 'ryba/oozie/server'
```

## Kafka Broker

```bash
./bin/ryba install -m 'ryba/kafka/broker'
```

## Ganglia Collector

```bash
./bin/ryba install -m 'ryba/ganglia/collector'
```

## Ganglia Monitor

```bash
./bin/ryba install -m 'ryba/ganglia/monitor'
```

## Nagios

```bash
./bin/ryba install -m 'ryba/nagios'
```
